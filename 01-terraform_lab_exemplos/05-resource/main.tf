provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  subnet_id              = "subnet-eddcdzz4"
  # availability_zones = ["us-east-1"] # configurando zona para criar maquinas
  tags = {
    Name = "Minha Maquina Simples EC2"
  }
}