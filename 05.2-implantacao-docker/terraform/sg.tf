resource "aws_security_group" "libera_ssh" {
  name        = "libera_ssh_desafio_devops"
  description = "Libera a porta 22 para as maquinas criadas no desafio devops"

  ingress = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Liberacao geral de fora para dentro"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      from_port        = 80
      to_port          = 80
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
    Name = "libera_ssh_desafio"
  }
}
