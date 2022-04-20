output "public_dns" {
  value = aws_instance.vm.public_dns
}

output "rds" {
  value = aws_db_instance.rds.endpoint
}
