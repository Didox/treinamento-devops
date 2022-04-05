
output "aws_instance_e_ssh" {
  value = [
    for key, item in aws_instance.web :
      item.id
  ]
}

