terraform {
  backend "remote" {
    organization = "didox"

    workspaces {
      name = "TerraformLabTreinamento"
    }
  }
}