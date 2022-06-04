provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

# resource "aws_key_pair" "chave_ssh_desafio" {
#   key_name   = "chave_ssh_desafio_pub"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6n+egdpEqWRcnPIc0D/c7IVgErojxHldA8C1iFKIKX98GlSXMmzVdVedxMjcs6AMU0puGGBQruQEy9HqqwsbFcEyjPofIJa4oztyXn0VqSPjdWsD3dr/5IkUu38Q0CooLgOXfabSIytwj+810cWX7Kno2GVAfOLKRI0/+JE9Q4poX47DpyF8yN3dRN6aitQmnPioq3NwViHbdHpe7mGhUju6nItDNuN39KeCgA4s2yuDz42sFXsBxjdt3F7j6iaq3iPpOC8+5sYpER1KpxQ4JO1g3dsIOoNzlyLvkUMY46JKCoRh/0crTRKhNXhARiFUpNWOQDfyLFepSD9+hq9Xfa6es4rXKGi0eSv9v5Fc119hSVObjoF7760FDSp/1IMccQw06JS2V/HRHIY9+s5Pm9ChoO/tpdglxPszD2vWjE7JrvHXVZlxyTEi5SQOTBGM/s3dONaW0/tU9ZMgNOgMZ1AOkspyDltXsP2hDK6fOLj5rt8P1vqq//D2wY1Pc04M= danilo@Macbooks-MacBook-Pro.local"
# }

resource "aws_instance" "jenkins" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.large"
  key_name      = "chave_publica_desafio_kubernetes"
  tags = {
    Name = "jenkins"
  }
  vpc_security_group_ids = [
    aws_security_group.jenkins.id
  ]
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
      cidr_blocks      = ["0.0.0.0/0"]
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
    "ssh -i ~/Desktop/devops/id_rsa ubuntu@${aws_instance.jenkins.public_dns}"
  ]
}
