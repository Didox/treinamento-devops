resource "aws_security_group" "acessos_masters" {
  name        = "k8s-acessos_masters-${var.meu_nome}"
  description = "acessos inbound traffic"
  vpc_id = var.vpc_id
  
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
    Name = "acessos_masters-${var.meu_nome}"
  }
}

resource "aws_security_group" "acessos_haproxy" {
  name        = "k8s-haproxy-${var.meu_nome}"
  description = "acessos inbound traffic"
  vpc_id = var.vpc_id
  
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
    Name = "allow_haproxy_ssh-${var.meu_nome}"
  }
}

resource "aws_security_group" "acessos_workers" {
  name        = "k8s-workers-${var.meu_nome}"
  description = "acessos inbound traffic"
  vpc_id = var.vpc_id
  
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
    Name = "acessos_workers-${var.meu_nome}"
  }
}