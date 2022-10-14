locals {
  connect_vcs_repo = var.oauth_token_id == null || var.repository_identifier == null ? {} : { create = true }
}

resource "tfe_workspace" "default" {
  name                      = var.name
  organization              = var.terraform_organization
  auto_apply                = var.auto_apply
  file_triggers_enabled     = var.file_triggers_enabled
  terraform_version         = var.terraform_version
  trigger_prefixes          = var.trigger_prefixes
  global_remote_state       = var.global_remote_state
  queue_all_runs            = true
  remote_state_consumer_ids = var.remote_state_consumer_ids
  working_directory         = var.working_directory

  dynamic "vcs_repo" {
    for_each = local.connect_vcs_repo

    content {
      identifier         = var.repository_identifier
      branch             = var.branch
      ingress_submodules = false
      oauth_token_id     = var.oauth_token_id
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
