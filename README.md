# terraform-tfe-mcaf-workspace

MCAF Terraform module to create and manage a Terraform Cloud workspace.

With default options Terraform will also create and manage a GitHub repository and attach it to the Terraform Cloud
workspace. If the `create_repository` option is set to `false`, the GitHub repository should already exist or the
Terraform run will fail.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | >= 0.51.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_notification_configuration.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration) | resource |
| [tfe_team_access.defautl](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_variable.clear_text_env_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.clear_text_hcl_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.clear_text_terraform_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_env_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_hcl_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_terraform_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace_settings.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_settings) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | A name for the Terraform workspace | `string` | n/a | yes |
| <a name="input_terraform_organization"></a> [terraform\_organization](#input\_terraform\_organization) | The Terraform Enterprise organization to create the workspace in | `string` | n/a | yes |
| <a name="input_agent_pool_id"></a> [agent\_pool\_id](#input\_agent\_pool\_id) | Agent pool ID, requires "execution\_mode" to be set to agent | `string` | `null` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| <a name="input_auto_apply_run_trigger"></a> [auto\_apply\_run\_trigger](#input\_auto\_apply\_run\_trigger) | Whether to automatically apply changes when a Terraform plan is successful. | `bool` | `false` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | The Git branch to trigger the TFE workspace for | `string` | `"main"` | no |
| <a name="input_clear_text_env_variables"></a> [clear\_text\_env\_variables](#input\_clear\_text\_env\_variables) | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| <a name="input_clear_text_hcl_variables"></a> [clear\_text\_hcl\_variables](#input\_clear\_text\_hcl\_variables) | An optional map with clear text HCL Terraform variables | `map(string)` | `{}` | no |
| <a name="input_clear_text_terraform_variables"></a> [clear\_text\_terraform\_variables](#input\_clear\_text\_terraform\_variables) | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | Which execution mode to use | `string` | `"remote"` | no |
| <a name="input_file_triggers_enabled"></a> [file\_triggers\_enabled](#input\_file\_triggers\_enabled) | Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | The installation ID of the Github App; this conflicts with `oauth_token_id` and can only be used if `oauth_token_id` is not used | `string` | `null` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | Allow all workspaces in the organization to read the state of this workspace | `bool` | `null` | no |
| <a name="input_notification_configuration"></a> [notification\_configuration](#input\_notification\_configuration) | Notification configuration for this workspace | <pre>list(object({<br>    destination_type = string<br>    enabled          = optional(bool, true)<br>    url              = string<br>    triggers = optional(list(string), [<br>      "run:created",<br>      "run:planning",<br>      "run:needs_attention",<br>      "run:applying",<br>      "run:completed",<br>      "run:errored",<br>    ])<br>  }))</pre> | `[]` | no |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | The OAuth token ID of the VCS provider; this conflicts with `github_app_installation_id` and can only be used if `github_app_installation_id` is not used | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID of the project where the workspace should be created | `string` | `null` | no |
| <a name="input_queue_all_runs"></a> [queue\_all\_runs](#input\_queue\_all\_runs) | When set to false no initial run is queued and all runs triggered by a webhook will not be queued, necessary if you need to set variable sets after creation. | `bool` | `true` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | A set of workspace IDs set as explicit remote state consumers for this workspace | `set(string)` | `null` | no |
| <a name="input_repository_identifier"></a> [repository\_identifier](#input\_repository\_identifier) | The VCS repository to connect the workspace to. E.g. for GitHub this is: <organization>/<repository> | `string` | `null` | no |
| <a name="input_sensitive_env_variables"></a> [sensitive\_env\_variables](#input\_sensitive\_env\_variables) | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| <a name="input_sensitive_hcl_variables"></a> [sensitive\_hcl\_variables](#input\_sensitive\_hcl\_variables) | An optional map with sensitive HCL Terraform variables | <pre>map(object({<br>    sensitive = string<br>  }))</pre> | `{}` | no |
| <a name="input_sensitive_terraform_variables"></a> [sensitive\_terraform\_variables](#input\_sensitive\_terraform\_variables) | An optional map with sensitive Terraform variables | `map(string)` | `{}` | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | The SSH key ID to assign to the workspace | `string` | `null` | no |
| <a name="input_team_access"></a> [team\_access](#input\_team\_access) | An optional map with team IDs and workspace access to assign | <pre>map(object({<br>    access  = string,<br>    team_id = string,<br>  }))</pre> | `{}` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The version of Terraform to use for this workspace | `string` | `"latest"` | no |
| <a name="input_trigger_prefixes"></a> [trigger\_prefixes](#input\_trigger\_prefixes) | List of repository-root-relative paths which should be tracked for changes | `list(string)` | <pre>[<br>  "modules"<br>]</pre> | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | A relative path that Terraform will execute within | `string` | `"terraform"` | no |
| <a name="input_workspace_tags"></a> [workspace\_tags](#input\_workspace\_tags) | A list of tag names for this workspace. Note that tags must only contain lowercase letters, numbers, colons, or hyphens | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Terraform workspace ID |
<!-- END_TF_DOCS -->

## License

**Copyright:** Schuberg Philis

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
