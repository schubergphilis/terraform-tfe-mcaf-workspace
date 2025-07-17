output "id" {
  value       = tfe_workspace.default.id
  description = "HCP Terraform workspace ID"
}

output "name" {
  value       = tfe_workspace.default.name
  description = "HCP Terraform workspace name"
}

output "workspace_id" {
  value       = tfe_workspace.default.id
  description = "(**DEPRECATED**) HCP Terraform workspace ID"
}

output "workspace_name" {
  value       = tfe_workspace.default.name
  description = "(**DEPRECATED**) HCP Terraform workspace name"
}
