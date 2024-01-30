variable "name" {
  type        = string
  description = "A name for the Terraform workspace"
}

variable "agent_pool_id" {
  type        = string
  default     = null
  description = "Agent pool ID, requires \"execution_mode\" to be set to agent"
}

variable "auto_apply" {
  type        = bool
  default     = false
  description = "Whether to automatically apply changes when a Terraform plan is successful"
}

variable "auto_apply_run_trigger" {
  type        = bool
  default     = false
  description = "Whether to automatically apply changes when a Terraform plan is successful."
}

variable "branch" {
  type        = string
  default     = "main"
  description = "The Git branch to trigger the TFE workspace for"
}

variable "clear_text_env_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text environment variables"
}

variable "clear_text_hcl_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text HCL Terraform variables"
}

variable "clear_text_terraform_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with clear text Terraform variables"
}

variable "execution_mode" {
  type        = string
  default     = "remote"
  description = "Which execution mode to use"

  validation {
    condition     = var.execution_mode == "agent" || var.execution_mode == "local" || var.execution_mode == "remote"
    error_message = "The execution_mode value must be either \"agent\", \"local\", or \"remote\"."
  }
}

variable "file_triggers_enabled" {
  type        = bool
  default     = true
  description = "Whether to filter runs based on the changed files in a VCS push"
}

variable "github_app_installation_id" {
  type        = string
  default     = null
  description = "The installation ID of the Github App; this conflicts with `oauth_token_id` and can only be used if `oauth_token_id` is not used"
}

variable "global_remote_state" {
  type        = bool
  default     = null
  description = "Allow all workspaces in the organization to read the state of this workspace"
}

variable "notification_configuration" {
  type = list(object({
    destination_type = string
    enabled          = optional(bool, true)
    url              = string
    triggers = optional(list(string), [
      "run:created",
      "run:planning",
      "run:needs_attention",
      "run:applying",
      "run:completed",
      "run:errored",
    ])
  }))
  default     = []
  description = "Notification configuration for this workspace"

  validation {
    condition     = alltrue([for v in var.notification_configuration : contains(["slack", "microsoft-teams"], v.destination_type)])
    error_message = "Supported destination types are: slack, microsoft-teams"
  }
}

variable "oauth_token_id" {
  type        = string
  default     = null
  description = "The OAuth token ID of the VCS provider; this conflicts with `github_app_installation_id` and can only be used if `github_app_installation_id` is not used"
}

variable "project_id" {
  type        = string
  default     = null
  description = "ID of the project where the workspace should be created"
}

variable "queue_all_runs" {
  type        = bool
  default     = true
  description = "When set to false no initial run is queued and all runs triggered by a webhook will not be queued, necessary if you need to set variable sets after creation."
}

variable "remote_state_consumer_ids" {
  type        = set(string)
  default     = null
  description = "A set of workspace IDs set as explicit remote state consumers for this workspace"
}

variable "repository_identifier" {
  type        = string
  default     = null
  description = "The VCS repository to connect the workspace to. E.g. for GitHub this is: <organization>/<repository>"
}

variable "sensitive_env_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with sensitive environment variables"
}

variable "sensitive_terraform_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with sensitive Terraform variables"
}

variable "sensitive_hcl_variables" {
  type = map(object({
    sensitive = string
  }))
  default     = {}
  description = "An optional map with sensitive HCL Terraform variables"
}

variable "ssh_key_id" {
  type        = string
  default     = null
  description = "The SSH key ID to assign to the workspace"
}

variable "team_access" {
  type = map(object({
    access  = string,
    team_id = string,
  }))
  default     = {}
  description = "An optional map with team IDs and workspace access to assign"
}

variable "terraform_version" {
  type        = string
  default     = "latest"
  description = "The version of Terraform to use for this workspace"
}

variable "terraform_organization" {
  type        = string
  description = "The Terraform Enterprise organization to create the workspace in"
}

variable "trigger_prefixes" {
  type        = list(string)
  default     = ["modules"]
  description = "List of repository-root-relative paths which should be tracked for changes"
}

variable "working_directory" {
  type        = string
  default     = "terraform"
  description = "A relative path that Terraform will execute within"
}

variable "workspace_tags" {
  type        = list(string)
  default     = null
  description = "A list of tag names for this workspace. Note that tags must only contain lowercase letters, numbers, colons, or hyphens"

  validation {
    condition     = alltrue([for workspace_tag in coalesce(var.workspace_tags, []) : can(regex("[-:a-z0-9]", workspace_tag))])
    error_message = "One or more tags are not in the correct format (lowercase letters, numbers, colons, or hyphens)"
  }
}
