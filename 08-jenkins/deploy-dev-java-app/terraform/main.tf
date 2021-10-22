provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

variable ami_dev {
  type        = string
  description = "Digite o ID da AMI"
}


resource "aws_instance" "dev_deploy_jenkins" {
  ami           = var.ami_dev
  instance_type = "t2.micro"

  for_each = toset(["dev", "stage", "prod"])

  key_name      = "chave-jenkins"
  tags = {
    Name = "dev_deploy_jenkins_${each.key}"
  }
  vpc_security_group_ids = [aws_security_group.acesso_jenkins_dev.id]
}

resource "aws_security_group" "acesso_jenkins_dev" {
  name        = "acesso_jenkins_dev"
  description = "acesso_jenkins_dev inbound traffic"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "SSH from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
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
    Name = "jenkins-dev-img-lab"
  }
}

output "dev_deploy_jenkins" {
  value = [
    for key, item in aws_instance.k8s_workers :
      "public_ip-${key}: ${aws_instance.dev_deploy_jenkins.public_ip}"
  ]
}