locals {
  connect_vcs_repo = var.repository_identifier != null ? { create = true } : {}
}

################################################################################
# Workspace
################################################################################

resource "tfe_workspace" "default" {
  name                   = var.name
  allow_destroy_plan     = var.allow_destroy_plan
  assessments_enabled    = var.assessments_enabled
  auto_apply             = var.auto_apply
  auto_apply_run_trigger = var.auto_apply_run_trigger
  description            = var.description
  file_triggers_enabled  = var.file_triggers_enabled
  organization           = var.terraform_organization
  project_id             = var.project_id
  queue_all_runs         = var.queue_all_runs
  ssh_key_id             = var.ssh_key_id
  tag_names              = var.workspace_tags
  terraform_version      = var.terraform_version
  trigger_patterns       = var.trigger_patterns
  trigger_prefixes       = var.trigger_prefixes
  working_directory      = var.working_directory

  dynamic "vcs_repo" {
    for_each = local.connect_vcs_repo

    content {
      branch                     = var.branch
      github_app_installation_id = var.github_app_installation_id
      identifier                 = var.repository_identifier
      ingress_submodules         = false
      oauth_token_id             = var.oauth_token_id
    }
  }

  lifecycle {
    precondition {
      condition     = can(local.connect_vcs_repo.true) ? (var.github_app_installation_id != null || var.oauth_token_id != null) : true
      error_message = "VCS repository requires either a GitHub App installation ID or an OAuth token ID"
    }
  }
}

resource "tfe_workspace_settings" "default" {
  agent_pool_id             = var.execution_mode == "agent" ? var.agent_pool_id : null
  execution_mode            = var.execution_mode
  global_remote_state       = var.global_remote_state
  remote_state_consumer_ids = var.remote_state_consumer_ids
  workspace_id              = tfe_workspace.default.id
}

resource "tfe_notification_configuration" "default" {
  for_each = var.notification_configuration

  name             = each.key
  destination_type = each.value.destination_type
  enabled          = each.value.enabled
  triggers         = each.value.triggers
  url              = each.value.url
  workspace_id     = tfe_workspace.default.id
}

resource "tfe_variable" "clear_text_env_variables" {
  for_each = var.clear_text_env_variables

  key          = each.key
  value        = each.value
  category     = "env"
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "sensitive_env_variables" {
  for_each = var.sensitive_env_variables

  key          = each.key
  value        = each.value
  category     = "env"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "clear_text_terraform_variables" {
  for_each = var.clear_text_terraform_variables

  key          = each.key
  value        = each.value
  category     = "terraform"
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "sensitive_terraform_variables" {
  for_each = var.sensitive_terraform_variables

  key          = each.key
  value        = each.value
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "clear_text_hcl_variables" {
  for_each = var.clear_text_hcl_variables

  key          = each.key
  value        = each.value
  category     = "terraform"
  hcl          = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_variable" "sensitive_hcl_variables" {
  for_each = var.sensitive_hcl_variables

  key          = each.key
  value        = each.value.sensitive
  category     = "terraform"
  hcl          = true
  sensitive    = true
  workspace_id = tfe_workspace.default.id
}

resource "tfe_workspace_variable_set" "default" {
  for_each = var.variable_set_ids

  variable_set_id = each.value
  workspace_id    = tfe_workspace.default.id
}

################################################################################
# RBAC
################################################################################

data "tfe_team" "default" {
  for_each = toset(keys(var.team_access))

  name         = each.value
  organization = var.terraform_organization
}

resource "tfe_team_access" "default" {
  for_each = var.team_access

  access       = each.value.access
  team_id      = data.tfe_team.default[each.key].id
  workspace_id = tfe_workspace.default.id

  dynamic "permissions" {
    for_each = each.value.permissions != null ? { create = true } : {}

    content {
      run_tasks         = each.value.permissions["run_tasks"]
      runs              = each.value.permissions["runs"]
      sentinel_mocks    = each.value.permissions["sentinel_mocks"]
      state_versions    = each.value.permissions["state_versions"]
      variables         = each.value.permissions["variables"]
      workspace_locking = each.value.permissions["workspace_locking"]
    }
  }
}
