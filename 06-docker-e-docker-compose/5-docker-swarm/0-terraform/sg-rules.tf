resource "aws_security_group_rule" "acessos_workers_rule_ssh" {
  type             = "ingress"
  description      = "Libera acessos"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.acessos_workers.id
}
resource "aws_security_group_rule" "acessos_workers_masters" {
  type             = "ingress"
  description      = "Libera acessos"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_workers.id
  security_group_id = aws_security_group.acessos_masters.id
}

resource "aws_security_group_rule" "acessos_master_rule_ssh" {
  type             = "ingress"
  description      = "Libera acessos"
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.acessos_masters.id
}

resource "aws_security_group_rule" "acessos_master_master" {
  type             = "ingress"
  description      = "Libera acessos"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_masters.id
  security_group_id = aws_security_group.acessos_masters.id
}

resource "aws_security_group_rule" "acessos_master_workers" {
  type             = "ingress"
  description      = "Libera acessos"
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.acessos_masters.id
  security_group_id = aws_security_group.acessos_workers.id
}

resource "aws_security_group_rule" "acessos_master_master_http_3000" {
  type             = "ingress"
  description      = "Libera acessos http"
  from_port        = 3000
  to_port          = 3000
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.acessos_masters.id
}

resource "aws_security_group_rule" "acessos_master_workers_http_3000" {
  type             = "ingress"
  description      = "Libera acessos http"
  from_port        = 3000
  to_port          = 3000
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.acessos_workers.id
}