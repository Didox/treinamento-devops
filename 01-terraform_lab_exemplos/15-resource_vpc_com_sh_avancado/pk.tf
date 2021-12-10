resource "aws_key_pair" "chave_key_turi" {
  key_name   = "chave_key_Turi_Terraform"
  public_key = var.ssh_pub_key # sua chave publica da maquina 
}