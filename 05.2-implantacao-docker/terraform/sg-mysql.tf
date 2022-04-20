resource "aws_security_group" "libera_mysql" {
  name        = "libera_mysql_desafio_devops"
  description = "Libera a porta 3306 para as maquinas criadas no desafio devops"

  ingress = [
    {
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Liberacao geral de fora para dentro"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Liberacao geral na parte interna"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "libera_mysql_desafio"
  }
}
