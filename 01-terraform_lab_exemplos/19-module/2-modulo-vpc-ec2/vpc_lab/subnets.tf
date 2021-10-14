resource "aws_subnet" "subnet_1a" {
  vpc_id            = aws_vpc.vpc_lab.id
  cidr_block        = "${substr(var.cidr_block, 0, 6)}.8.0/22"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-lab-danilo-subnet-1a"
  }
}

resource "aws_subnet" "subnet_1b" {
  vpc_id            = aws_vpc.vpc_lab.id
  cidr_block        = "${substr(var.cidr_block, 0, 6)}.28.0/22"
  availability_zone = "us-east-1b"

  tags = {
    Name = "tf-lab-danilo-subnet-1b"
  }
}

resource "aws_subnet" "subnet_1c" {
  vpc_id            = aws_vpc.vpc_lab.id
  cidr_block        = "${substr(var.cidr_block, 0, 6)}.48.0/22"
  availability_zone = "us-east-1c"

  tags = {
    Name = "tf-lab-danilo-subnet-1c"
  }
}