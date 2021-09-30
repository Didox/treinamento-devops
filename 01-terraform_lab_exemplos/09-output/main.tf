provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "${var.ami_ubuntu_preferido}"
  instance_type = "t2.micro"
  tags = {
    Name = "Maquina de Teste EC2"
  }
}