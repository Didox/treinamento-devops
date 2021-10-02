provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "jenkins" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.large"
  key_name      = "Itau_treinamento"
  tags = {
    Name = "jenkins"
  }
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
}

resource "aws_security_group" "jenkins" {
  name        = "acessos_jenkins"
  description = "acessos_jenkins inbound traffic"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "SSH from VPC"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
      description : "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "jenkins-lab"
  }
}

# terraform refresh para mostrar o ssh
output "jenkins" {
  value = [
    "jenkins",
    "id: ${aws_instance.jenkins.id}",
    "private: ${aws_instance.jenkins.private_ip}",
    "public: ${aws_instance.jenkins.public_ip}",
    "public_dns: ${aws_instance.jenkins.public_dns}",
    "ssh -i ~/projetos/devops/id_rsa_itau_treinamento ubuntu@${aws_instance.jenkins.public_dns}"
  ]
}
