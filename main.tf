locals {
  connect_vcs_repo = var.repository_identifier != null ? { create = true } : {}

  # When working_directory is set, trigger_patterns should include it, otherwise
  # trigger_patterns should be null.
  trigger_patterns_empty_or_null = var.trigger_patterns == null || try(length(var.trigger_patterns) == 0, true)
  trigger_patterns = (
    var.working_directory != null && !local.trigger_patterns_empty_or_null ?
    concat(var.trigger_patterns, ["${var.working_directory}/*"]) :
    null
  )

  trigger_prefixes_empty_or_null = var.trigger_prefixes == null || try(length(var.trigger_prefixes) == 0, true)
  trigger_prefixes               = local.trigger_prefixes_empty_or_null ? null : var.trigger_prefixes

  # Use var.variable_set_ids if set, otherwise use var.variable_set_names to get variable set IDs.
  variable_set_ids = (
    length(var.variable_set_ids) > 0 ? var.variable_set_ids :
    { for vs in data.tfe_variable_set.default : vs.name => vs.id }
  )
}

# Get variable set IDs.
data "tfe_variable_set" "default" {
  for_each = var.variable_set_names

  name = each.key
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
  file_triggers_enabled  = local.trigger_patterns == null && local.trigger_prefixes == null ? false : var.file_triggers_enabled
  organization           = var.terraform_organization
  project_id             = var.project_id
  queue_all_runs         = var.queue_all_runs
  speculative_enabled    = var.speculative_enabled
  ssh_key_id             = var.ssh_key_id
  tag_names              = var.workspace_tags
  terraform_version      = var.terraform_version
  trigger_patterns       = var.file_triggers_enabled ? local.trigger_patterns : null
  trigger_prefixes       = var.file_triggers_enabled ? local.trigger_prefixes : null
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
  for_each = nonsensitive(toset(keys(var.notification_configuration)))

  name             = each.key
  destination_type = nonsensitive(var.notification_configuration[each.key].destination_type)
  enabled          = nonsensitive(var.notification_configuration[each.key].enabled)
  triggers         = nonsensitive(var.notification_configuration[each.key].triggers)
  url              = var.notification_configuration[each.key].url
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
  for_each = local.variable_set_ids

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
