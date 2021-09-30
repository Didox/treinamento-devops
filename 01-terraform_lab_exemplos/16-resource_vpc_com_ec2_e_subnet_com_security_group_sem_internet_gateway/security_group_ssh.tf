# https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest/submodules/ssh#input_auto_computed_egress_rules
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

# ingress = [  # inbound - de fora (internet) para dentro da da maquina
# egress = [ # outbound - de dentro nda maquina, para fora (internet)

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_security_group" "allow_ssh1" {
  name        = "allow_ssh_1_vpc_terraform"
  description = "Allow SSH inbound traffic criado pelo terraform VPC"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"] # pega meu IP dinamicamente
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
      ipv6_cidr_blocks = ["::/0"]
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


# resource "aws_security_group" "allow_ssh2" {
#   name        = "allow_ssh_2_vpc_terraform"
#   description = "Allow SSH inbound traffic criado pelo terraform VPC"

#   ingress = [
#     {
#       description      = "SSH from VPC"
#       from_port        = 22
#       to_port          = 22
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       prefix_list_ids = null,
#       security_groups: null,
#       self: null
#     }
#   ]

#   egress = [
#     {
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       prefix_list_ids = null,
#       security_groups: null,
#       self: null,
#       description: "Libera dados da rede interna"
#     }
#   ]

#   tags = {
#     Name = "allow_ssh"
#   }
# }