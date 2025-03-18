output "variable_set_id" {
  value       = var.variable_set != null ? tfe_variable_set.default[0].id : null
  description = "The Terraform Cloud variable set ID"
}

output "workspace_name" {
  value       = tfe_workspace.default.name
  description = "The Terraform Cloud workspace name"
}

output "workspace_id" {
  value       = tfe_workspace.default.id
  description = "The Terraform Cloud workspace ID"
}
