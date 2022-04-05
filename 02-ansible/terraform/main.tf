provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = "treinamento-turma1"
  tags = {
    Name = "Maquina para teste ansible"
  }
  vpc_security_group_ids = [aws_security_group.allow_ssh_ansible.id]
}

output dns {
  value = aws_instance.web.public_dns
}



