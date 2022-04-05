provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"] # ou ["099720109477"] ID master com permissão para busca

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*"] # exemplo de como listar um nome de AMI - 'aws ec2 describe-images --region us-east-1 --image-ids ami-09e67e426f25ce0d7' https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html
  }
}

resource "aws_instance" "maquina_nginx" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "treinamento-turma1_itau"
  tags = {
    Name = "maquina_ansible_com_nginx"
  }
  vpc_security_group_ids = ["${aws_security_group.acessos.id}"]
}

resource "aws_security_group" "acessos" {
  name        = "acessos"
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

# https://github.com/cytopia/terraform-aws-rds/blob/v1.28.1/examples/complete-mssql/main.tf
resource "aws_security_group" "acesso_sql_server" {
  name        = "acesso_sql_server"
  description = "Habilita porta padrao mysql"

  ingress = [
    {
      description      = "Porta padrao acesso_sql_server"
      from_port        = 1433
      to_port          = 1433
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    }
  ]

  tags = {
    Name = "acesso_sql_server"
  }
}

resource "aws_db_instance" "default" {
  engine            = "sqlserver-ex"
  engine_version    = "14.00.1000.169.v1"
  instance_class    = "db.t2.medium"
  allocated_storage = 20 # aloca 5 GiB
  storage_encrypted = false
  license_model             = "license-included"

  # name     = "demodb" # para sqlserver-ex o nome da base de dados tem que ser nulo e gera automático
  username = "demouser"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "1433"

  publicly_accessible = false # libera acesso publico
  vpc_security_group_ids = ["${aws_security_group.acesso_sql_server.id}"]
  backup_retention_period = 0 # não criar backup periódico
  # preferred_backup_window = "07:00-09:00" # hora que vai realizar o backup
  deletion_protection = false # não protegido para exclusão
  skip_final_snapshot = true # não criar snapshot - caso de o erro "Error: DB Instance FinalSnapshotIdentifier is required when a final snapshot is required"
  # final_snapshot_identifier = true # caso de o erro "Error: DB Instance FinalSnapshotIdentifier is required when a final snapshot is required"
  tags = {
    Name = "meu sqlserver"
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
