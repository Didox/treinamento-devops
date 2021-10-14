resource "aws_route_table" "rt_terraform" {
  vpc_id = aws_vpc.vpc_lab.id

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
    Name = "route_table_terraform"
  }
}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.subnet_1a.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "b1" {
  subnet_id      = aws_subnet.subnet_1b.id
  route_table_id = aws_route_table.rt_terraform.id
}

resource "aws_route_table_association" "c1" {
  subnet_id      = aws_subnet.subnet_1c.id
  route_table_id = aws_route_table.rt_terraform.id
}
