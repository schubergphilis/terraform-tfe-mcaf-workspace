# github-vcs

This Terraform submodule builds on the root module to create an HCP Terraform workspace and connect it to a GitHub repository.

It first writes a `backend.tf` file to the workspace directory in the GitHub repository, then creates and configures the workspace to use a VCS-driven workflow.

## Usage

The following variables are required to use this module:

- `name`: A name for the Terraform workspace
- `repository_identifier`: The repository identifier to connect the workspace to
- `terraform_organization`: The Terraform organization to create the workspace in

And you will need to set either of the following to configure the VCS workflow:

- `github_app_installation_id`: The GitHub App installation ID to use
- `oauth_token_id`: The OAuth token ID of the VCS provider

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
