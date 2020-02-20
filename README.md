# terraform-tfe-mcaf-workspace

MCAF Terraform module to create and manage a Terraform Cloud workspace.

With default options Terraform will also create and manage a GitHub repository and attach it to the Terraform Cloud  
workspace. If the `create_repository` option is set to `false`, the GitHub repository should already exist or the  
Terraform run will fail.

<!--- BEGIN_TF_DOCS --->
## Providers

| Name | Version |
|------|---------|
| tfe | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| auto\_apply | Whether to automatically apply changes when a Terraform plan is successful | `bool` | `false` | no |
| branch | The Git branch to trigger the TFE workspace for | `string` | `"master"` | no |
| clear\_text\_env\_variables | An optional map with clear text environment variables | `map(string)` | `{}` | no |
| clear\_text\_terraform\_variables | An optional map with clear text Terraform variables | `map(string)` | `{}` | no |
| file\_triggers\_enabled | Whether to filter runs based on the changed files in a VCS push | `bool` | `true` | no |
| github\_repository | The GitHub repository (org/repo) to connect the workspace to | `string` | n/a | yes |
| name | A name for the Terraform workspace | `string` | n/a | yes |
| oauth\_token\_id | The OAuth token ID of the VCS provider | `string` | n/a | yes |
| sensitive\_env\_variables | An optional map with sensitive environment variables | `map(string)` | `{}` | no |
| sensitive\_terraform\_variables | An optional map with sensitive Terraform variables | `map(string)` | `{}` | no |
| slack\_notification\_url | The Slack Webhook URL to send notification to | `string` | n/a | yes |
| terraform\_organization | The Terraform Enterprise organization to create the workspace in | `string` | n/a | yes |
| terraform\_version | The version of Terraform to use for this workspace | `string` | `"latest"` | no |
| trigger\_prefixes | List of repository-root-relative paths which should be tracked for changes | `list(string)` | <pre>[<br>  "modules"<br>]<br></pre> | no |
| working\_directory | A relative path that Terraform will execute within | `string` | `"terraform"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The Terraform workspace ID |
<!--- END_TF_DOCS --->

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
