
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnets" "vpc_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  tags = {
    Name = "subnet-1?-leandro-vb"
  }
}

data "aws_subnet" "vpc_public_subnets_ids" {
  for_each = toset(data.aws_subnets.vpc_public_subnets.ids)
  id       = each.value
}