*** cria recurso de busca em forma de objeto no resource exemplo:

No caso abaixo está muscando um EC2 que seja ubunto 

```tf
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["221334852100"] # List of AMI (canonical user ID / User ARN - 099720109477 - este canonical é padrão da AWS serve para localizar todos os AMIs
arn:aws:iam::221334852100:user/professor.danilo ) owners or self (the current account)- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
}
```

Aqui vincula o ID do AMI no resource

```tf
resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}
```