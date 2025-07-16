terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 18.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.66"
    }
  }
  required_version = ">= 1.9"
}
