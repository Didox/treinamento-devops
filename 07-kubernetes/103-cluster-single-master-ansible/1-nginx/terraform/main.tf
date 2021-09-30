provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "maquina_nginx" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = "Itau_treinamento"
  tags = {
    Name = "maquina_ansible_com_nginx"
  }
  vpc_security_group_ids = ["${aws_security_group.acessos.id}"]
}

resource "aws_security_group" "acessos" {
  name        = "acessos_nginx"
  description = "acessos inbound traffic"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      description      = "Acesso HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      description      = "Acesso HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_ssh"
  }
}
# terraform refresh para mostrar o ssh
output "aws_instance_e_ssh" {
  value = [
    aws_instance.maquina_nginx.public_ip,
    "ssh -i id_rsa_itau_treinamento ubuntu@${aws_instance.maquina_nginx.public_dns}"
  ]
}

# para liberar a internet interna da maquina, colocar regra do outbound "Outbound rules" como "All traffic"
# ssh -i ../../id_rsa_itau_treinamento ubuntu@ec2-3-93-240-108.compute-1.amazonaws.com
# conferir 
