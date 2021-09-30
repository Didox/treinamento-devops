resource "aws_security_group" "acesso_geral" {
  name        = "acesso_geral"
  description = "Treinamento concrete com acesso a geral"
  ingress {
    cidr_blocks      = [
      "0.0.0.0/0",
    ]
    description      = "Para acessar a maquina com todas as portas"
    from_port        = 0
    ipv6_cidr_blocks = [
      "::/0",
    ]
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }

  egress {
    cidr_blocks      = [
      "0.0.0.0/0",
    ]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = [
      "::/0",
    ]
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }

  tags = {
    Name = "acesso_geral"
  }
}

# para liberar a internet interna da maquina, colocar regra do outbound "Outbound rules" como "All traffic"
# ssh -i ~/.ssh/terraform-aws ubuntu@ec2-54-242-44-197.compute-1.amazonaws.com