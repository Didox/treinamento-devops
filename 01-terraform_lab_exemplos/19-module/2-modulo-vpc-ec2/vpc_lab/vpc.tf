resource "aws_vpc" "vpc_lab" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = var.nome
  }
}