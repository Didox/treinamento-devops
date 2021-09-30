resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-lab-danilo-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-lab-danilo-subnet"
  }
}

resource "aws_subnet" "my_subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-lab-danilo-subnet_b"
  }
}

resource "aws_subnet" "my_subnet_c" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.30.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf-lab-danilo-subnet_c"
  }
}