provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web2" {
  subnet_id = "subnet-02d7741675f030d69"
  ami = "ami-083654bd07b5da81d"
  instance_type = "t2.micro"
  key_name = "chave_key" # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-083654bd07b5da81d"]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-zerati-tf"
  }
}

resource "aws_key_pair" "chave_key" {
  key_name   = "chave_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABUAHUAHuaHaUc=" # sua chave publica da maquina 
}