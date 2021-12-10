resource "aws_instance" "web2" {
  subnet_id = aws_subnet.my_subnet_a.id
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.chave_key_turi.key_name # a chave que vc tem na maquina pessoal
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "EC2-TURI-TERRAFORM"
  }
}