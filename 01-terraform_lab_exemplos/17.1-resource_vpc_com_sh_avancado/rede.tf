# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "main" {
  cidr_block       = "10.40.80.0/20" # uma classe de IP
  instance_tenancy = "default"       # - (Optional) A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr.

  tags = {
    Name = "vpc-turma3-mendcav-tf"
  }
}
output "name" {
  value = aws_vpc.main.id

}

resource "aws_subnet" "my_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.40.80.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-lab-turi-subnet_1a"
  }
}

resource "aws_subnet" "my_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.40.81.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "tf-lab-turi-subnet_1b"
  }
}

resource "aws_subnet" "my_subnet_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.40.82.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "tf-lab-turi-subnet_1c"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "aws_internet_gateway_terraform_turi"
  }
}

resource "aws_route_table" "rt_terraform" {
  vpc_id = aws_vpc.main.id

  route = [
    {
      carrier_gateway_id         = ""
      cidr_block                 = "0.0.0.0/0"
      destination_prefix_list_id = ""
      egress_only_gateway_id     = ""
      gateway_id                 = aws_internet_gateway.gw.id
      instance_id                = ""
      ipv6_cidr_block            = ""
      local_gateway_id           = ""
      nat_gateway_id             = ""
      network_interface_id       = ""
      transit_gateway_id         = ""
      vpc_endpoint_id            = ""
      vpc_peering_connection_id  = ""
    }
  ]

  tags = {
    Name = "route_table_terraform_turi"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet_a.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.my_subnet_b.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.my_subnet_c.id
  route_table_id = aws_route_table.rt_terraform.id
}
