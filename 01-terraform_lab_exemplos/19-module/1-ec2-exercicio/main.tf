provider "aws" {
  region = "us-east-1"
}

module "criar_instancia_da_erika" {
  source = "./erika"
  nome = "Um nome"
  tipo = "large"
}

module "criar_instancia_da_erika_micro" {
  source = "./erika"
  nome = "Um nome"
  tipo = "micro"
}