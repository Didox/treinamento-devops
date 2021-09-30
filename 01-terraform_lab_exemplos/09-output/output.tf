# https://www.terraform.io/docs/language/values/outputs.html
output "instance_ip_addr" {
  value = [aws_instance.web.private_ip, aws_instance.web.public_ip]
  description = "Mostra os IPs publicos e privados da maquina criada."
}