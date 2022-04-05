resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_lab.id

  tags = {
    Name = "aws_internet_gateway_terraform"
  }
}