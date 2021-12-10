provider "aws" {
  region = "us-east-1"
}

# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
# resource "aws_vpc" "main" {
#   cidr_block       = "10.40.80.0/20" # uma classe de IP
#   instance_tenancy = "default"  # - (Optional) A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr.

#   tags = {
#     Name = "vpc-turma3-mendcav-tf"
#   }
# }
# output name {
#   value       = aws_vpc.main.id

# }

# resource "aws_subnet" "my_subnet_a" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.40.80.0/24"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "tf-lab-turi-subnet_1a"
#   }
# }

# resource "aws_subnet" "my_subnet_b" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.40.81.0/24"
#   availability_zone = "us-east-1b"

#   tags = {
#     Name = "tf-lab-turi-subnet_1b"
#   }
# }

# resource "aws_subnet" "my_subnet_c" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.40.82.0/24"
#   availability_zone = "us-east-1c"

#   tags = {
#     Name = "tf-lab-turi-subnet_1c"
#   }
# }


# # resource "aws_network_interface" "my_subnet" {
# #   subnet_id   = aws_subnet.my_subnet_a.id
# #   private_ips = ["172.16.10.101"] # IP definido para instancia
# #   # security_groups = ["${aws_security_group.allow_ssh1.id}"]

# #   tags = {
# #     Name = "primary_network_interface my_subnet"
# #   }
# # }


# # resource "aws_network_interface" "my_subnet_b" {
# #   subnet_id   = aws_subnet.my_subnet_b.id
# #   private_ips = ["172.16.20.100"] # IP definido para instancia
# #   # security_groups = ["${aws_security_group.allow_ssh1.id}"]

# #   tags = {
# #     Name = "primary_network_interface my_subnet_b"
# #   }
# # }