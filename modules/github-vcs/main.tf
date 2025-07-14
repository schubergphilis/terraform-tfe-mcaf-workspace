# Write our backend file to the workspace directory.
resource "github_repository_file" "backend" {
  commit_author       = var.commit_author
  commit_email        = var.commit_email
  file                = "${var.working_directory}/${var.backend_file_name}"
  overwrite_on_create = true
  repository          = split("/", var.repository_identifier)[1]

  content = templatefile("${path.module}/../../templates/backends.tf.tpl", {
    organization = var.terraform_organization,
    workspace    = var.name
  })

  lifecycle {
    ignore_changes = [commit_author, commit_email]
  }
}

# Get variable set IDs.
data "tfe_variable_set" "default" {
  for_each = var.variable_set_names

  name = each.key
}

# Create the workspace.
module "tfe_workspace" {
  source = "../.."

  name                       = var.name
  auto_apply                 = true
  file_triggers_enabled      = true
  github_app_installation_id = var.github_app_installation_id
  global_remote_state        = var.global_remote_state
  oauth_token_id             = var.oauth_token_id
  project_id                 = var.project_id
  repository_identifier      = var.repository_identifier
  queue_all_runs             = false # Prevent queuing a run before backend config is written.
  terraform_organization     = var.terraform_organization
  terraform_version          = var.terraform_version
  trigger_patterns           = var.trigger_patterns
  variable_set_ids           = { for vs in data.tfe_variable_set.default : vs.name => vs.id }
  working_directory          = var.working_directory
  workspace_tags             = var.workspace_tags
}

# Queue a run in the created workspace after the backend file has been created.
resource "tfe_workspace_run" "default" {
  workspace_id = module.tfe_workspace.workspace_id
  depends_on   = [github_repository_file.backend]

  apply {
    manual_confirm = false
    retry          = false
  }
}
