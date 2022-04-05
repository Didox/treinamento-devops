provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "maquina_wp" {
  ami = "${var.amis["us-east-1-ubuntu18"]}"
  instance_type = "${var.instance_type.micro}"
  key_name = "treinamento-turma1"
  tags = {
    Name = "maquina_ansible_com_worpress"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_geral.id}"]
}

# terraform refresh para mostrar o ssh
output "aws_instance_e_ssh" {
  value = [
    aws_instance.maquina_wp.public_ip,
    "ssh -i id_rsatreinamento ubuntu@${aws_instance.maquina_wp.public_dns}"
  ]
}

# para liberar a internet interna da maquina, colocar regra do outbound "Outbound rules" como "All traffic"
# ssh -i ../../id_rsatreinamento ubuntu@ec2-3-93-240-108.compute-1.amazonaws.com
# conferir 
