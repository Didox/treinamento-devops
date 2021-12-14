provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "k8s_proxy" {
  ami           = "ami-0d6806446a46f9b9c"
  subnet_id = "subnet-08d1dcb60f40fe297"
  instance_type = "t2.medium"
  key_name      = "Ubuntu-dev-bira"
  associate_public_ip_address = true
  tags = {
    Name = "k8s-haproxy"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 8
  }
  vpc_security_group_ids = [aws_security_group.acessos_haproxy.id]
}

resource "aws_instance" "k8s_masters" {
  ami           = "ami-0d6806446a46f9b9c"
  associate_public_ip_address = true
  subnet_id = "subnet-08d1dcb60f40fe297"
  instance_type = "t2.large"
  key_name      = "Ubuntu-dev-bira"
  count         = 3
  tags = {
    Name = "k8s-master-${count.index}"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 32
  }
  vpc_security_group_ids = [aws_security_group.acessos_masters.id]
  depends_on = [
    aws_instance.k8s_workers,
  ]
}

resource "aws_instance" "k8s_workers" {
  ami           = "ami-0d6806446a46f9b9c"
  instance_type = "t2.medium"
  key_name      = "Ubuntu-dev-bira"
  associate_public_ip_address = true
  subnet_id = "subnet-08d1dcb60f40fe297"
  count         = 3
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 32
  }
  tags = {
    Name = "k8s_workers-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers.id]
}


resource "aws_security_group" "acessos_masters" {
  name        = "k8s-acessos_masters"
  description = "acessos inbound traffic"
  vpc_id = "vpc-01a2749453ce92707"

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "acessos_masters"
  }
}

resource "aws_security_group" "acessos_haproxy" {
  name        = "k8s-haproxy"
  description = "acessos inbound traffic"
  vpc_id = "vpc-01a2749453ce92707"

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "allow_haproxy_ssh"
  }
}

resource "aws_security_group" "acessos_workers" {
  name        = "k8s-workers"
  description = "acessos inbound traffic"
  vpc_id = "vpc-01a2749453ce92707"

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "acessos_workers"
  }
}

resource "aws_security_group_rule" "acessos_workers_rule_ssh" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  source_security_group_id = aws_security_group.acessos_workers.id
}
resource "aws_security_group_rule" "acessos_workers_masters" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_workers.id
  security_group_id = aws_security_group.acessos_masters.id
}

resource "aws_security_group_rule" "acessos_master_rule_tcp" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 30000
  to_port          = 30000
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  source_security_group_id = aws_security_group.acessos_masters.id
}
resource "aws_security_group_rule" "acessos_master_rule_ssh" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  source_security_group_id = aws_security_group.acessos_masters.id
}
resource "aws_security_group_rule" "acessos_haproxy_master_hproxy" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_masters.id
  security_group_id = aws_security_group.acessos_haproxy.id
}
resource "aws_security_group_rule" "acessos_haproxy_master_master {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_masters.id
  security_group_id = aws_security_group.acessos_masters.id
}
resource "aws_security_group_rule" "acessos_haproxy_master_workers" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_masters.id
  security_group_id = aws_security_group.acessos_workers.id
}

resource "aws_security_group_rule" "acessos_haproxy_master" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_haproxy.id
  security_group_id = aws_security_group.acessos_masters.id
}
resource "aws_security_group_rule" "acessos_haproxy_workers" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_haproxy.id
  security_group_id = aws_security_group.acessos_workers.id
}
resource "aws_security_group_rule" "acessos_haproxy_ssh" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  source_security_group_id = aws_security_group.acessos_haproxy.id
}

output "k8s-masters" {
  value = [
    for key, item in aws_instance.k8s_masters :
      "k8s-master ${key+1} - ${item.private_ip} - ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_workers" {
  value = [
    for key, item in aws_instance.k8s_workers :
      "k8s-workers ${key+1} - ${item.private_ip} - ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_proxy" {
  value = [
    "k8s_proxy - ${aws_instance.k8s_proxy.private_ip} - ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.k8s_proxy.public_dns} -o ServerAliveInterval=60"
  ]
}