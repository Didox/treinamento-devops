*** Programa qual é o recurso que iremos criar no provider, exemplo uma máquina feita na AWS t2.micro com a AMI(codigo da máquina) ami-09e67e426f25ce0d7

```tf
resource "aws_instance" "web" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  tags = {
    Name = "Minha Maquina Simples EC2"
  }
}
```