provider "aws" {
  region = "us-east-1"
}

resource "aws_ami_from_instance" "ami-jenkins" {
  name               = "terraform-jenkins-${var.versao}"
  source_instance_id = var.resource_id
}

variable "resource_id" {
  type        = string
  description = "Qual o ID da máquina?"
}

variable "versao" {
  type        = string
  description = "Qual versão da imagem?"
}

output "ami" {
  value = [
    "AMI: ${aws_ami_from_instance.ami-jenkins.id}"
  ]
}
