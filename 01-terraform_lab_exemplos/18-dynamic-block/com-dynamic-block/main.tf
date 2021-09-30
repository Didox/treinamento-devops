provider "aws" {
  region = "us-east-2"
  profile = "awsouza"
}

# com bloco dinâmico
resource "aws_security_group" "com-dynamic-block" {
  name        = "security-dinamico-sg"
  description = "SG de teste, com dynamic-block"

  dynamic "ingress" {
    for_each = var.default_ingress
    content {
      description = ingress.value["description"]
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  tags = {
    Name = "security-dinamico"
  }
}

output id {
  value = aws_security_group.com-dynamic-block.id
}
