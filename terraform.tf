terraform {
  required_version = ">= 1.7.0"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.68.0"
    }
  }
}
