provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "master" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.large"
  key_name      = "treinamento-turma1_itau"
  tags = {
    Name = "maquina-cluster-kubernetes-master"
  }
  vpc_security_group_ids = ["${aws_security_group.acessos_master.id}"]
  depends_on = [
    aws_instance.workers,
  ]
}

resource "aws_instance" "workers" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.medium"
  key_name      = "treinamento-turma1_itau"
  tags = {
    Name = "maquina-cluster-kubernetes-${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acessos_workers.id}"]
  count                  = 2
}


resource "aws_security_group" "acessos_master" {
  name        = "acessos_master"
  description = "acessos_workers inbound traffic"

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
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups = [
        "${aws_security_group.acessos_workers.id}",
      ]
      self    = false
      to_port = 0
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 20001
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 20001
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 3000
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3000
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 31350
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 31350
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 9090
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 9090
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
    Name = "k8s-lab"
  }
}

resource "aws_security_group" "acessos_workers" {
  name        = "acessos_workers"
  description = "acessos_workers inbound traffic"

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
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "sg-03d14421ddaf2f77e",
      ]
      self             = false
      to_port          = 0
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
    Name = "k8s-lab"
  }
}


# terraform refresh para mostrar o ssh
output "master" {
  value = [
    "master",
    "private: ${aws_instance.master.private_ip}",
    "public: ${aws_instance.master.public_ip}",
    "ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.master.public_dns}"
  ]
}

# terraform refresh para mostrar o ssh
output "aws_instance_e_ssh" {
  value = [
    for key, item in aws_instance.workers :
    "worker ${key + 1} - private - ${item.private_ip} - public - ${item.public_ip} - ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${item.public_dns}"
  ]
}