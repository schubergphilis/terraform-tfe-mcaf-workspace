# terraform-tfe-mcaf-workspace

MCAF Terraform module to create and manage a Terraform Cloud workspace.

With default options Terraform will also create and manage a GitHub repository and attach it to the Terraform Cloud  
workspace. If the `create_repository` option is set to `false`, the GitHub repository should already exist or the  
Terraform run will fail.

## Providers

| Name | Version |
|------|---------|
| tfe | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| github\_repository | The Github organization to connect the workspace to | `string` | n/a | yes |
| name | A name for the Terraform workspace | `string` | n/a | yes |
| oauth\_token\_id | The OAuth token ID of the VCS provider | `string` | n/a | yes |
| repository\_description | A description for the Github repository | `string` | n/a | yes |
| slack\_notification\_url | The Slack Webhook URL to send notification to | `string` | n/a | yes |
| terraform\_organization | The Terraform Enterprise organization to create the workspace in | `string` | n/a | yes |
| auto\_apply | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| branch | The Git branch to trigger the TFE workspace for | `string` | `"master"` | no |
| branch\_protection | The Github branches to protect from forced pushes and deletion | <pre>list(object({<br>    branches       = list(string)<br>    enforce_admins = bool<br><br>    required_reviews = object({<br>      dismiss_stale_reviews           = bool<br>      dismissal_teams                 = list(string)<br>      dismissal_users                 = list(string)<br>      required_approving_review_count = number<br>      require_code_owner_reviews      = bool<br>    })<br><br>    required_checks = object({<br>      strict   = bool<br>      contexts = list(string)<br>    })<br><br>    restrictions = object({<br>      users = list(string)<br>      teams = list(string)<br>    })<br>  }))</pre> | `[]` | no |
| clear\_text\_env\_variables | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| clear\_text\_terraform\_variables | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| connect\_vcs\_repo | Whether or not to connect a VCS repo to the workspace | `bool` | `true` | no |
| create\_repository | Whether or not to create a new repository | `bool` | `false` | no |
| file\_triggers\_enabled | Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| github\_admins | A list of Github teams that should have admin access | `list(string)` | `[]` | no |
| github\_writers | A list of Github teams that should have write access | `list(string)` | `[]` | no |
| repository\_private | Make the Github repository private | `bool` | `true` | no |
| sensitive\_env\_variables | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| sensitive\_terraform\_variables | An optional map with sensitive Terraform variables | `map(string)` | `{}` | no |
| terraform\_version | The version of Terraform to use for this workspace | `string` | `"latest"` | no |
| trigger\_prefixes | List of repository-root-relative paths which should be tracked for changes | `list(string)` | <pre>[<br>  "modules"<br>]</pre> | no |
| working\_directory | A relative path that Terraform will execute within | `string` | `"terraform"` | no |

## Outputs

| Name | Description |
|------|-------------|
| workspace\_id | The Terraform workspace ID |

