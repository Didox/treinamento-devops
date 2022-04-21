provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_key_pair" "chave_ssh_desafio" {
  key_name   = "chave_ssh_desafio_pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+5jxtFhMTOhwTDTaQCkedHuQ3UB6yGMMfubyPRoZQEYHnJAUFOfi2zjkbZqjwT3W0J4mLpWoMP3a89MXhpg/fy2/pyvADinXJFBqLaxzPGVpNCUPGhWuWL4i/6aToAxlg6RZXAeVWW7W3oEjnVzHi98Gw0SveACDttnQKoHPKgpdPNFCxDb3xjUo39qTaV6zmZDh/89C+e3VZw/hLl2YrFKvBLqs2efZmiqQP8sPHfIQA01YTVc+6zykNIc+X0FtAzf1Wsw0BenHBdKTFR1O/PKgQuEGQ+ez0B2h6aG17UHowY8uDCfNN/mtZGN8be6MAUYudKT43a7utDFWzNPCf3N0YbvrZsTGkqaeWMKw4SGvciIWJstimR61/jEAb+uBNGPdfEzIwNcZxfSBEIj1HCo+Y1a7VyeyR+cEvAbxpVifNmOvI20090vC3o1TpK2zU0zzbGZWBBlBN3f2qWrUB0nEKlBx1iijAiHVG7AhocuBji+/IoMOKvtjWhYAWKtM= danilo@Macbooks-MacBook-Pro.local"
}

resource "aws_instance" "jenkins" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.large"
  key_name      = aws_key_pair.chave_ssh_desafio.key_name
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
    "ssh -i /Users/danilo/Desktop/desafio_devops/terraform/ssh/id_rsa ubuntu@${aws_instance.jenkins.public_dns}"
  ]
}
