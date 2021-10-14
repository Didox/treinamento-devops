provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "treinamento-turma1_itau" # key chave publica cadastrada na AWS 
  # subnet_id        =  aws_subnet.my_subnet.id # vincula a subnet direto e gera o IP automático
  tags = {
    Name = "Maquina para testar VPC"
  }

  network_interface {
    network_interface_id = aws_network_interface.my_subnet.id # vincula a subnet com ip fixo
    device_index         = 0                                  # DeviceIndex - The network interface's position in the attachment order. For example, the first attached network interface has a DeviceIndex of 0. 
  }
}

resource "aws_instance" "web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "treinamento-turma1_itau"
  tags = {
    Name = "Maquina2 para testar VPC"
  }
  network_interface {
    network_interface_id = aws_network_interface.my_subnet_b.id # vincula a subnet com ip fixo
    device_index         = 0
  }
}

resource "aws_instance" "web3" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "treinamento-turma1_itau"
  tags = {
    Name = "Maquina3 para testar VPC"
  }
  subnet_id = aws_subnet.my_subnet_c.id
}