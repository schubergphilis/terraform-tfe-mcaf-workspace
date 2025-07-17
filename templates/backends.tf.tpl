# This file is managed by Terraform.

terraform {
  cloud {
    organization = "${organization}"

    workspaces {
      name = "${workspace}"
    }
  }
}
