*** cria variável para ser utilizado 

```tf
variable "ami_ubuntu_preferido" {
  type = string
  default = "ami-09e67e426f25ce0d7"
  description = "Uma das minhas maquinas favoritas na AWS"
}
```

Utiliza assim

```tf
resource "aws_instance" "web" {
  ami           = "${var.ami_ubuntu_preferido}"
  instance_type = "t2.micro"
  tags = {
    Name = "Maquina de Teste EC2"
  }
}
```

outr forma de criar variável
```tf
variable "amis" {
  default = {
    "us-east-1-ubuntu18" = "ami-013f17f36f8b1fefb"
    "us-east-1-ubuntu20" = "ami-042e8287309f5df03"
    "us-east-2-ubuntu20" = "ami-08962a4068733a2b6"
  }
}
```

Utiliza assim
```tf
resource "aws_instance" "maquina_wp" {
  ami = "${var.amis["us-east-1-ubuntu18"]}"
  instance_type = "${var.instance_type.micro}"
  key_name = "didox-terraform-key"
  tags = {
    Name = "maquina_ansible_com_worpress"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_geral.id}"]
}
```