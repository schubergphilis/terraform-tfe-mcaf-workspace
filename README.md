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
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | >= 0.61.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_notification_configuration.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration) | resource |
| [tfe_team_access.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_variable.clear_text_env_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.clear_text_hcl_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.clear_text_terraform_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_env_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_hcl_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.sensitive_terraform_variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace_settings.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_settings) | resource |
| [tfe_workspace_variable_set.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set) | resource |
| [tfe_team.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | A name for the Terraform workspace | `string` | n/a | yes |
| <a name="input_terraform_organization"></a> [terraform\_organization](#input\_terraform\_organization) | The Terraform Enterprise organization to create the workspace in | `string` | n/a | yes |
| <a name="input_agent_pool_id"></a> [agent\_pool\_id](#input\_agent\_pool\_id) | Agent pool ID, requires "execution\_mode" to be set to agent | `string` | `null` | no |
| <a name="input_allow_destroy_plan"></a> [allow\_destroy\_plan](#input\_allow\_destroy\_plan) | Whether destroy plans can be queued on the workspace | `bool` | `true` | no |
| <a name="input_assessments_enabled"></a> [assessments\_enabled](#input\_assessments\_enabled) | Whether to regularly run health assessments such as drift detection on the workspace | `bool` | `true` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| <a name="input_auto_apply_run_trigger"></a> [auto\_apply\_run\_trigger](#input\_auto\_apply\_run\_trigger) | Whether to automatically apply changes for runs that were created by run triggers from another workspace | `bool` | `false` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | The git branch to trigger the TFE workspace for | `string` | `"main"` | no |
| <a name="input_clear_text_env_variables"></a> [clear\_text\_env\_variables](#input\_clear\_text\_env\_variables) | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| <a name="input_clear_text_hcl_variables"></a> [clear\_text\_hcl\_variables](#input\_clear\_text\_hcl\_variables) | An optional map with clear text HCL Terraform variables | `map(string)` | `{}` | no |
| <a name="input_clear_text_terraform_variables"></a> [clear\_text\_terraform\_variables](#input\_clear\_text\_terraform\_variables) | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | A description for the workspace | `string` | `null` | no |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | Which execution mode to use | `string` | `"remote"` | no |
| <a name="input_file_triggers_enabled"></a> [file\_triggers\_enabled](#input\_file\_triggers\_enabled) | Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | The GitHub App installation ID to use | `string` | `null` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | Allow all workspaces in the organization to read the state of this workspace | `bool` | `null` | no |
| <a name="input_notification_configuration"></a> [notification\_configuration](#input\_notification\_configuration) | Notification configuration, using name as key and config as value | <pre>map(object({<br>    destination_type = string<br>    enabled          = optional(bool, true)<br>    url              = string<br>    triggers = optional(list(string), [<br>      "run:created",<br>      "run:planning",<br>      "run:needs_attention",<br>      "run:applying",<br>      "run:completed",<br>      "run:errored",<br>    ])<br>  }))</pre> | `{}` | no |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | The OAuth token ID of the VCS provider | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID of the project where the workspace should be created | `string` | `null` | no |
| <a name="input_queue_all_runs"></a> [queue\_all\_runs](#input\_queue\_all\_runs) | When set to false no initial run is queued and all runs triggered by a webhook will not be queued, necessary if you need to set variable sets after creation. | `bool` | `true` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | A set of workspace IDs set as explicit remote state consumers for this workspace | `set(string)` | `null` | no |
| <a name="input_repository_identifier"></a> [repository\_identifier](#input\_repository\_identifier) | The repository identifier to connect the workspace to | `string` | `null` | no |
| <a name="input_sensitive_env_variables"></a> [sensitive\_env\_variables](#input\_sensitive\_env\_variables) | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| <a name="input_sensitive_hcl_variables"></a> [sensitive\_hcl\_variables](#input\_sensitive\_hcl\_variables) | An optional map with sensitive HCL Terraform variables | <pre>map(object({<br>    sensitive = string<br>  }))</pre> | `{}` | no |
| <a name="input_sensitive_terraform_variables"></a> [sensitive\_terraform\_variables](#input\_sensitive\_terraform\_variables) | An optional map with sensitive Terraform variables | `map(string)` | `{}` | no |
| <a name="input_speculative_enabled"></a> [speculative\_enabled](#input\_speculative\_enabled) | Enables or disables speculative plans on PR/MR, enabled by default | `bool` | `true` | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | The SSH key ID to assign to the workspace | `string` | `null` | no |
| <a name="input_team_access"></a> [team\_access](#input\_team\_access) | Map of team names and either type of fixed access or custom permissions to assign | <pre>map(object({<br>    access = optional(string, null),<br>    permissions = optional(object({<br>      run_tasks         = bool<br>      runs              = string<br>      sentinel_mocks    = string<br>      state_versions    = string<br>      variables         = string<br>      workspace_locking = bool<br>    }), null)<br>  }))</pre> | `{}` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The version of Terraform to use for this workspace | `string` | `"latest"` | no |
| <a name="input_trigger_patterns"></a> [trigger\_patterns](#input\_trigger\_patterns) | List of glob patterns that describe the files Terraform Cloud monitors for changes. Trigger patterns are always appended to the root directory of the repository. Mutually exclusive with trigger-prefixes | `list(string)` | `null` | no |
| <a name="input_trigger_prefixes"></a> [trigger\_prefixes](#input\_trigger\_prefixes) | List of repository-root-relative paths which should be tracked for changes | `list(string)` | <pre>[<br>  "modules"<br>]</pre> | no |
| <a name="input_variable_set_ids"></a> [variable\_set\_ids](#input\_variable\_set\_ids) | Map of variable set ids to attach to the workspace | `map(string)` | `{}` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | A relative path that Terraform will execute within | `string` | `"terraform"` | no |
| <a name="input_workspace_tags"></a> [workspace\_tags](#input\_workspace\_tags) | A list of tag names for this workspace. Note that tags must only contain lowercase letters, numbers, colons, or hyphens | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The Terraform Cloud workspace ID |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | The Terraform Cloud workspace name |
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
