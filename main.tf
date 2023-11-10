locals {
  connect_vcs_repo = (var.oauth_token_id == null || var.github_app_installation_id == null) || var.repository_identifier == null ? {} : { create = true }
}

resource "tfe_workspace" "default" {
  name                      = var.name
  organization              = var.terraform_organization
  agent_pool_id             = var.agent_pool_id
  auto_apply                = var.auto_apply
  execution_mode            = var.execution_mode
  file_triggers_enabled     = var.file_triggers_enabled
  global_remote_state       = var.global_remote_state
  remote_state_consumer_ids = var.remote_state_consumer_ids
  ssh_key_id                = var.ssh_key_id
  tag_names                 = var.workspace_tags
  terraform_version         = var.terraform_version
  trigger_prefixes          = var.trigger_prefixes
  queue_all_runs            = true
  working_directory         = var.working_directory

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
}

resource "tfe_notification_configuration" "default" {
  count = var.slack_notification_url != null ? 1 : 0

  name             = tfe_workspace.default.name
  destination_type = "slack"
  enabled          = length(coalesce(var.slack_notification_triggers, [])) > 0
  triggers         = var.slack_notification_triggers
  url              = var.slack_notification_url
  workspace_id     = tfe_workspace.default.id
}

resource "tfe_team_access" "defautl" {
  for_each = var.team_access

  access       = each.value.access
  team_id      = each.value.team_id
  workspace_id = tfe_workspace.default.id
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
