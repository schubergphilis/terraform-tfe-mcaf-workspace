# terraform-tfe-mcaf-workspace

MCAF Terraform module to create and manage a Terraform Cloud workspace.

With default options Terraform will also create and manage a GitHub repository and attach it to the Terraform Cloud  
workspace. If the `create_repository` option is set to `false`, the GitHub repository should already exist or the  
Terraform run will fail.

<!--- BEGIN_TF_DOCS --->
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
