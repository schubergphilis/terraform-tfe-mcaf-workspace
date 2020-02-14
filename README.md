# terraform-tfe-mcaf-workspace

MCAF Terraform module to create and manage a Terraform Cloud workspace.

With default options Terraform will also create and manage a GitHub repository and attach it to the Terraform Cloud  
workspace. If the `create_repository` option is set to `false`, the GitHub repository should already exist or the  
Terraform run will fail.

<!--- BEGIN_TF_DOCS --->
<!--- END_TF_DOCS --->
