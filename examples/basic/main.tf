provider "tfe" {}

module "workspace-example" {
  source = "../.."

  name                   = "example"
  terraform_organization = "example-org"
}
