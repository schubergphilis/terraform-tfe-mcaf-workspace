output "workspace_name" {
  value       = tfe_workspace.default.name
  description = "The Terraform Cloud workspace name"
}

output "workspace_id" {
  value       = tfe_workspace.default.id
  description = "The Terraform Cloud workspace ID"
}
