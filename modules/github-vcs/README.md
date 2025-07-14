# github-vcs

This Terraform submodule builds on the root module to create an HCP Terraform workspace and connect it to a GitHub repository.

It first writes a `backend.tf` file to the workspace directory in the GitHub repository, then creates and configures the workspace to use a VCS-driven workflow.

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
