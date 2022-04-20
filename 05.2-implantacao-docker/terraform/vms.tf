resource "aws_instance" "vm" {
  ami                         = "ami-04505e74c0741db8d"
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.chave_ssh_desafio.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.libera_ssh.id
  ]

  tags = {
    Name = "Maquina-Java"
  }
}