output vpc_id {
  value       = aws_vpc.vpc_lab.id
  description = "Id da VPC"
}

output subnet_1a_id {
  value       = aws_subnet.subnet_1a.id
  description = "Subnet 1 A"
}

output subnet_1b_id {
  value       = aws_subnet.subnet_1b.id
  description = "Subnet 1 B"
}

output subnet_1c_id {
  value       = aws_subnet.subnet_1c.id
  description = "Subnet 1 C"
}
