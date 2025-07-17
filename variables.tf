variable "agent_pool_id" {
  type        = string
  default     = null
  description = "Agent pool ID, requires \"execution_mode\" to be set to agent"
}

variable "allow_destroy_plan" {
  type        = bool
  default     = true
  description = "Whether destroy plans can be queued on the workspace"
}

variable "assessments_enabled" {
  type        = bool
  default     = true
  description = "Whether to regularly run health assessments such as drift detection on the workspace"
}

variable "auto_apply" {
  type        = bool
  default     = false
  description = "Whether to automatically apply changes when a Terraform plan is successful"
}

variable "auto_apply_run_trigger" {
  type        = bool
  default     = false
  description = "Whether to automatically apply changes for runs that were created by run triggers from another workspace"
}

variable "branch" {
  type        = string
  default     = "main"
  description = "The git branch to trigger the TFE workspace for"
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

variable "description" {
  type        = string
  default     = null
  description = "A description for the workspace"
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
  description = "The GitHub App installation ID to use"
}

variable "global_remote_state" {
  type        = bool
  default     = null
  description = "Allow all workspaces in the organization to read the state of this workspace"
}

variable "name" {
  type        = string
  description = "A name for the Terraform workspace"
}

variable "notification_configuration" {
  type = map(object({
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
  default     = {}
  description = "Notification configuration, using name as key and config as value"
  nullable    = false

  validation {
    condition     = alltrue([for k, v in var.notification_configuration : contains(["email", "generic", "microsoft-teams", "slack"], v.destination_type)])
    error_message = "Supported destination types are: \"email\", \"generic\", \"microsoft-teams\", or \"slack\""
  }
}

variable "oauth_token_id" {
  type        = string
  default     = null
  description = "The OAuth token ID of the VCS provider"
}

variable "project_id" {
  type        = string
  default     = null
  description = "ID of the project the workspace should be added to"
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
  description = "The repository identifier to connect the workspace to"
}

variable "sensitive_env_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with sensitive environment variables"
}

variable "sensitive_hcl_variables" {
  type = map(object({
    sensitive = string
  }))
  default     = {}
  description = "An optional map with sensitive HCL Terraform variables"
}

variable "sensitive_terraform_variables" {
  type        = map(string)
  default     = {}
  description = "An optional map with sensitive Terraform variables"
}

variable "speculative_enabled" {
  type        = bool
  default     = true
  description = "Whether this workspace allows speculative plans. Setting this to false prevents Terraform from running plans on pull requests."
}

variable "ssh_key_id" {
  type        = string
  default     = null
  description = "The SSH key ID to assign to the workspace"
}

variable "team_access" {
  type = map(object({
    access = optional(string, null),
    permissions = optional(object({
      run_tasks         = bool
      runs              = string
      sentinel_mocks    = string
      state_versions    = string
      variables         = string
      workspace_locking = bool
    }), null)
  }))
  default     = {}
  description = "Map of team names and either type of fixed access or custom permissions to assign"
  nullable    = false

  validation {
    condition     = alltrue([for o in var.team_access : !(o.access != null && o.permissions != null)])
    error_message = "Cannot use \"access\" and \"permissions\" keys together when specifying a team's access."
  }
}

variable "terraform_organization" {
  type        = string
  description = "The Terraform organization to create the workspace in"
}

variable "terraform_version" {
  type        = string
  default     = "latest"
  description = "The version of Terraform to use for this workspace"
}

variable "trigger_patterns" {
  type        = list(string)
  default     = ["modules/**/*"]
  description = "List of glob patterns that describe the files Terraform Cloud monitors for changes. Trigger patterns are always appended to the root directory of the repository. Mutually exclusive with trigger-prefixes"
}

variable "trigger_prefixes" {
  type        = list(string)
  default     = null
  description = "List of repository-root-relative paths which should be tracked for changes"
}

variable "variable_set_ids" {
  type        = map(string)
  default     = {}
  description = "Map of variable set ids to attach to the workspace"
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

variable "working_directory" {
  type        = string
  default     = "terraform"
  description = "A relative path that Terraform will execute within"
}
