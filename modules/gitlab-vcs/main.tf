# Write our backend file to the workspace directory.
data "gitlab_project" "default" {
  path_with_namespace = var.repository_identifier
}

resource "gitlab_repository_file" "backend" {
  author_email          = var.commit_email
  author_name           = var.commit_author
  branch                = "main"
  create_commit_message = "Created ${var.working_directory}/${var.backend_file_name}"
  delete_commit_message = "Deleted ${var.working_directory}/${var.backend_file_name}"
  encoding              = "text"
  file_path             = "${var.working_directory}/${var.backend_file_name}"
  project               = data.gitlab_project.default.id
  update_commit_message = "Updated ${var.working_directory}/${var.backend_file_name}"

  content = templatefile("${path.module}/../../templates/backends.tf.tpl", {
    organization = var.terraform_organization,
    workspace    = var.name
  })
}

# Files created by this resource are fully managed. Any downstream updates will be replaced the
# next time Terraform runs.
resource "gitlab_repository_file" "managed" {
  for_each = { for k, v in var.repository_files : k => v if v.managed }

  author_email          = var.commit_email
  author_name           = var.commit_author
  branch                = "main"
  content               = each.value.content
  create_commit_message = "Created ${var.working_directory}/${var.backend_file_name}"
  delete_commit_message = "Deleted ${var.working_directory}/${var.backend_file_name}"
  encoding              = "text"
  file_path             = "${var.working_directory}/${each.key}"
  project               = data.gitlab_project.default.id
  update_commit_message = "Updated ${var.working_directory}/${var.backend_file_name}"
}

# Files created by this resource are a one time action. Any downstream content changes will not be
# overwritten. This helps to build a repository skeleton where you want some templating.
resource "gitlab_repository_file" "unmanaged" {
  for_each = { for k, v in var.repository_files : k => v if !v.managed }

  author_email          = var.commit_email
  author_name           = var.commit_author
  branch                = "main"
  content               = each.value.content
  create_commit_message = "Created ${var.working_directory}/${var.backend_file_name}"
  delete_commit_message = "Deleted ${var.working_directory}/${var.backend_file_name}"
  encoding              = "text"
  file_path             = "${var.working_directory}/${each.key}"
  project               = data.gitlab_project.default.id
  update_commit_message = "Updated ${var.working_directory}/${var.backend_file_name}"

  lifecycle {
    ignore_changes = [content]
  }
}

# Create the workspace.
module "workspace" {
  source = "../.."

  name                           = var.name
  agent_pool_id                  = var.agent_pool_id
  allow_destroy_plan             = var.allow_destroy_plan
  assessments_enabled            = var.assessments_enabled
  auto_apply                     = var.auto_apply
  auto_apply_run_trigger         = var.auto_apply_run_trigger
  branch                         = var.branch
  clear_text_env_variables       = var.clear_text_env_variables
  clear_text_hcl_variables       = var.clear_text_hcl_variables
  clear_text_terraform_variables = var.clear_text_terraform_variables
  description                    = var.description
  execution_mode                 = var.execution_mode
  file_triggers_enabled          = true # Changes to files trigger a plan.
  global_remote_state            = var.global_remote_state
  notification_configuration     = var.notification_configuration
  oauth_token_id                 = var.oauth_token_id
  project_id                     = var.project_id
  queue_all_runs                 = false # Prevent queuing a run before backend config is written.
  remote_state_consumer_ids      = var.remote_state_consumer_ids
  repository_identifier          = var.repository_identifier
  sensitive_env_variables        = var.sensitive_env_variables
  sensitive_hcl_variables        = var.sensitive_hcl_variables
  sensitive_terraform_variables  = var.sensitive_terraform_variables
  speculative_enabled            = var.speculative_enabled
  ssh_key_id                     = var.ssh_key_id
  team_access                    = var.team_access
  terraform_organization         = var.terraform_organization
  terraform_version              = var.terraform_version
  trigger_patterns               = var.trigger_patterns
  variable_set_ids               = var.variable_set_ids
  variable_set_names             = var.variable_set_names
  working_directory              = var.working_directory
  workspace_tags                 = var.workspace_tags
}

# Queue a run in the created workspace after the backend and repository files have been created.
resource "tfe_workspace_run" "default" {
  workspace_id = module.workspace.id

  depends_on = [
    gitlab_repository_file.backend,
    gitlab_repository_file.managed,
    gitlab_repository_file.unmanaged,
  ]

  apply {
    manual_confirm = false
    retry          = false
  }
}
