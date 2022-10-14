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
}

variable "file_triggers_enabled" {
  type        = bool
  default     = true
  description = "Whether to filter runs based on the changed files in a VCS push"
}

variable "global_remote_state" {
  type        = bool
  default     = null
  description = "Allow all workspaces in the organization to read the state of this workspace"
}

variable "oauth_token_id" {
  type        = string
  default     = null
  description = "The OAuth token ID of the VCS provider"
}

variable "remote_state_consumer_ids" {
  type        = set(string)
  default     = null
  description = "A set of workspace IDs set as explicit remote state consumers for this workspace"
}

variable "repository_identifier" {
  type        = string
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

variable "slack_notification_triggers" {
  type = list(string)
  default = [
    "run:created",
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored"
  ]
  description = "The array of triggers for which to send notifications to Slack"
}

variable "slack_notification_url" {
  type        = string
  default     = null
  description = "The Slack Webhook URL to send notification to"
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
