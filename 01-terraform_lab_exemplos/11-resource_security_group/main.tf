provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name = "treinamento-turma1_itau" # Nome da Key gerada pelo ssk-keygem e upada na AWS
  tags = {
    Name = "Minha Maquina Simples EC2"
  }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}