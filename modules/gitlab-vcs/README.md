# gitlab-vcs

This Terraform submodule builds on the root module to create an HCP Terraform workspace and connect it to a GitLab repository.

It first writes a `backend.tf` file to the workspace directory in the GitLab repository, then creates and configures the workspace to use a VCS-driven workflow.

## Usage

The following variables are required to use this module:

- `name`: A name for the Terraform workspace
- `oauth_token_id`: The OAuth token ID of the VCS provider
- `repository_identifier`: The repository identifier to connect the workspace to
- `terraform_organization`: The Terraform organization to create the workspace in

## Adding additional files

Additional files can be created by populating `var.repository_files`. If, for example, you wanted to generate a `README.md` in the repository so that it shows in the workspace, you could do so by adding:

```hcl
repository_files = {
  "README.md" = {
    content = file("${path.root}/files/README.md")
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~> 18.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.66 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | ~> 18.0 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.66 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_workspace"></a> [workspace](#module\_workspace) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [gitlab_repository_file.backend](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/repository_file) | resource |
| [gitlab_repository_file.managed](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/repository_file) | resource |
| [gitlab_repository_file.unmanaged](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/repository_file) | resource |
| [tfe_workspace_run.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_run) | resource |
| [gitlab_project.default](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | A name for the Terraform workspace | `string` | n/a | yes |
| <a name="input_oauth_token_id"></a> [oauth\_token\_id](#input\_oauth\_token\_id) | The OAuth token ID of the VCS provider | `string` | n/a | yes |
| <a name="input_repository_identifier"></a> [repository\_identifier](#input\_repository\_identifier) | The repository identifier to connect the workspace to | `string` | n/a | yes |
| <a name="input_terraform_organization"></a> [terraform\_organization](#input\_terraform\_organization) | The Terraform organization to create the workspace in | `string` | n/a | yes |
| <a name="input_agent_pool_id"></a> [agent\_pool\_id](#input\_agent\_pool\_id) | Agent pool ID, requires "execution\_mode" to be set to agent | `string` | `null` | no |
| <a name="input_allow_destroy_plan"></a> [allow\_destroy\_plan](#input\_allow\_destroy\_plan) | Whether destroy plans can be queued on the workspace | `bool` | `true` | no |
| <a name="input_assessments_enabled"></a> [assessments\_enabled](#input\_assessments\_enabled) | Whether to regularly run health assessments such as drift detection on the workspace | `bool` | `true` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `true` | no |
| <a name="input_auto_apply_run_trigger"></a> [auto\_apply\_run\_trigger](#input\_auto\_apply\_run\_trigger) | Whether to automatically apply changes for runs that were created by run triggers from another workspace | `bool` | `false` | no |
| <a name="input_backend_file_name"></a> [backend\_file\_name](#input\_backend\_file\_name) | The name of the backend file to create in the repository | `string` | `"backend.tf"` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | The git branch to trigger the TFE workspace for | `string` | `"main"` | no |
| <a name="input_clear_text_env_variables"></a> [clear\_text\_env\_variables](#input\_clear\_text\_env\_variables) | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| <a name="input_clear_text_hcl_variables"></a> [clear\_text\_hcl\_variables](#input\_clear\_text\_hcl\_variables) | An optional map with clear text HCL Terraform variables | `map(string)` | `{}` | no |
| <a name="input_clear_text_terraform_variables"></a> [clear\_text\_terraform\_variables](#input\_clear\_text\_terraform\_variables) | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| <a name="input_commit_author"></a> [commit\_author](#input\_commit\_author) | Committer author name to use. | `string` | `null` | no |
| <a name="input_commit_email"></a> [commit\_email](#input\_commit\_email) | Committer email address to use. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A description for the workspace | `string` | `null` | no |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | Which execution mode to use | `string` | `"remote"` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | Allow all workspaces in the organization to read the state of this workspace | `bool` | `null` | no |
| <a name="input_notification_configuration"></a> [notification\_configuration](#input\_notification\_configuration) | Notification configuration, using name as key and config as value | <pre>map(object({<br/>    destination_type = string<br/>    enabled          = optional(bool, true)<br/>    url              = string<br/>    triggers = optional(list(string), [<br/>      "run:created",<br/>      "run:planning",<br/>      "run:needs_attention",<br/>      "run:applying",<br/>      "run:completed",<br/>      "run:errored",<br/>    ])<br/>  }))</pre> | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | ID of the project the workspace should be added to | `string` | `null` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | A set of workspace IDs set as explicit remote state consumers for this workspace | `set(string)` | `null` | no |
| <a name="input_repository_files"></a> [repository\_files](#input\_repository\_files) | A map of files that should be created in the workspace directory | <pre>map(object({<br/>    content = string<br/>    managed = optional(bool, true)<br/>  }))</pre> | `{}` | no |
| <a name="input_sensitive_env_variables"></a> [sensitive\_env\_variables](#input\_sensitive\_env\_variables) | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| <a name="input_sensitive_hcl_variables"></a> [sensitive\_hcl\_variables](#input\_sensitive\_hcl\_variables) | An optional map with sensitive HCL Terraform variables | <pre>map(object({<br/>    sensitive = string<br/>  }))</pre> | `{}` | no |
| <a name="input_sensitive_terraform_variables"></a> [sensitive\_terraform\_variables](#input\_sensitive\_terraform\_variables) | An optional map with sensitive Terraform variables | `map(string)` | `{}` | no |
| <a name="input_speculative_enabled"></a> [speculative\_enabled](#input\_speculative\_enabled) | Whether this workspace allows speculative plans. Setting this to false prevents HCP Terraform or the Terraform Enterprise instance from running plans on pull requests, which can improve security if the VCS repository is public or includes untrusted contributors. | `bool` | `true` | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | The SSH key ID to assign to the workspace | `string` | `null` | no |
| <a name="input_team_access"></a> [team\_access](#input\_team\_access) | Map of team names and either type of fixed access or custom permissions to assign | <pre>map(object({<br/>    access = optional(string, null),<br/>    permissions = optional(object({<br/>      run_tasks         = bool<br/>      runs              = string<br/>      sentinel_mocks    = string<br/>      state_versions    = string<br/>      variables         = string<br/>      workspace_locking = bool<br/>    }), null)<br/>  }))</pre> | `{}` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The version of Terraform to use for this workspace | `string` | `"latest"` | no |
| <a name="input_trigger_patterns"></a> [trigger\_patterns](#input\_trigger\_patterns) | List of glob patterns that describe the files Terraform Cloud monitors for changes. Trigger patterns are always appended to the root directory of the repository. Mutually exclusive with trigger-prefixes | `list(string)` | <pre>[<br/>  "modules/**/*"<br/>]</pre> | no |
| <a name="input_variable_set_ids"></a> [variable\_set\_ids](#input\_variable\_set\_ids) | Map of variable set IDs to attach to the workspace | `map(string)` | `{}` | no |
| <a name="input_variable_set_names"></a> [variable\_set\_names](#input\_variable\_set\_names) | Set of variable set names to attach to the workspace | `set(string)` | `[]` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | A relative path that Terraform will execute within | `string` | `"terraform"` | no |
| <a name="input_workspace_tags"></a> [workspace\_tags](#input\_workspace\_tags) | A list of tag names for this workspace. Note that tags must only contain lowercase letters, numbers, colons, or hyphens | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | HCP Terraform workspace ID |
| <a name="output_name"></a> [name](#output\_name) | HCP Terraform workspace name |
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
