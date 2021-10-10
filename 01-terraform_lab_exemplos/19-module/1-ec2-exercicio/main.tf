provider "aws" {
  region = "us-east-1"
}

module "criar_instancia" {
  source = "./instancia"
  nome = "Um nome"
}
