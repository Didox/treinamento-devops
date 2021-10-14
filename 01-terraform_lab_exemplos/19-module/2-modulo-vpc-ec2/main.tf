provider "aws" {
  region = "us-east-1"
}

module "vpc_lab" {
  source     = "./vpc_lab"
  nome       = "Terraform VPC Modulo"
  cidr_block = "172.17.0.0/16"
}

module "ec2_labs" {
  source    = "./ec2_lab"
  nome      = "Uma maquina lab Terraform module"
  vpc_id    = module.vpc_lab.vpc_id
  config    = [
    {
      Tipo = "t2.micro",
      Nome = "001",
      SubnetId = module.vpc_lab.subnet_1a_id
    },
    {
      Tipo = "t2.medium",
      Nome = "002",
      SubnetId = module.vpc_lab.subnet_1b_id
    },
    {
      Tipo = "t2.large",
      Nome = "003",
      SubnetId = module.vpc_lab.subnet_1c_id
    }
  ]
}

resource "aws_eip" "exemplo_1" {
  vpc = true
}

resource "aws_eip" "exemplo_2" {
  vpc = true
}

resource "aws_eip" "exemplo_3" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc_1" {
  instance_id   = module.ec2_labs.aws_instance_e_ssh[0]
  allocation_id = aws_eip.exemplo_1.id
}

resource "aws_eip_association" "eip_assoc_2" {
  instance_id   = module.ec2_labs.aws_instance_e_ssh[1]
  allocation_id = aws_eip.exemplo_2.id
}

resource "aws_eip_association" "eip_assoc_3" {
  instance_id   = module.ec2_labs.aws_instance_e_ssh[2]
  allocation_id = aws_eip.exemplo_3.id
}