# terraform-tfe-mcaf-workspace

MCAF Terraform module to create and manage a Terraform Cloud workspace.

With default options Terraform will also create and manage a GitHub repository and attach it to the Terraform Cloud
workspace. If the `create_repository` option is set to `false`, the GitHub repository should already exist or the
Terraform run will fail.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| tfe | >= 0.51.0 |

## Providers

| Name | Version |
|------|---------|
| tfe | >= 0.51.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | A name for the Terraform workspace | `string` | n/a | yes |
| repository\_identifier | The VCS repository to connect the workspace to. E.g. for GitHub this is: <organization>/<repository> | `string` | n/a | yes |
| terraform\_organization | The Terraform Enterprise organization to create the workspace in | `string` | n/a | yes |
| agent\_pool\_id | Agent pool ID, requires "execution\_mode" to be set to agent | `string` | `null` | no |
| auto\_apply | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| auto\_apply\_run\_trigger | Whether to automatically apply changes when a Terraform plan is successful. | `bool` | `false` | no |
| branch | The Git branch to trigger the TFE workspace for | `string` | `"main"` | no |
| clear\_text\_env\_variables | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| clear\_text\_hcl\_variables | An optional map with clear text HCL Terraform variables | `map(string)` | `{}` | no |
| clear\_text\_terraform\_variables | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| execution\_mode | Which execution mode to use | `string` | `"remote"` | no |
| file\_triggers\_enabled | Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| github\_app\_installation\_id | The installation ID of the Github App; this conflicts with `oauth_token_id` and can only be used if `oauth_token_id` is not used | `string` | `null` | no |
| global\_remote\_state | Allow all workspaces in the organization to read the state of this workspace | `bool` | `null` | no |
| notification\_configuration | Notification configuration for this workspace | <pre>list(object({<br>    destination_type = string<br>    enabled          = optional(bool, true)<br>    url              = string<br>    triggers = optional(list(string), [<br>      "run:created",<br>      "run:planning",<br>      "run:needs_attention",<br>      "run:applying",<br>      "run:completed",<br>      "run:errored",<br>    ])<br>  }))</pre> | `[]` | no |
| oauth\_token\_id | The OAuth token ID of the VCS provider; this conflicts with `github_app_installation_id` and can only be used if `github_app_installation_id` is not used | `string` | `null` | no |
| project\_id | ID of the project where the workspace should be created | `string` | `null` | no |
| queue\_all\_runs | When set to false no initial run is queued and all runs triggered by a webhook will not be queued, necessary if you need to set variable sets after creation. | `bool` | `true` | no |
| remote\_state\_consumer\_ids | A set of workspace IDs set as explicit remote state consumers for this workspace | `set(string)` | `null` | no |
| sensitive\_env\_variables | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| sensitive\_hcl\_variables | An optional map with sensitive HCL Terraform variables | <pre>map(object({<br>    sensitive = string<br>  }))</pre> | `{}` | no |
| sensitive\_terraform\_variables | An optional map with sensitive Terraform variables | `map(string)` | `{}` | no |
| ssh\_key\_id | The SSH key ID to assign to the workspace | `string` | `null` | no |
| team\_access | An optional map with team IDs and workspace access to assign | <pre>map(object({<br>    access  = string,<br>    team_id = string,<br>  }))</pre> | `{}` | no |
| terraform\_version | The version of Terraform to use for this workspace | `string` | `"latest"` | no |
| trigger\_prefixes | List of repository-root-relative paths which should be tracked for changes | `list(string)` | <pre>[<br>  "modules"<br>]</pre> | no |
| working\_directory | A relative path that Terraform will execute within | `string` | `"terraform"` | no |
| workspace\_tags | A list of tag names for this workspace. Note that tags must only contain lowercase letters, numbers, colons, or hyphens | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform workspace ID |

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
