data "aws_ami" "ami-ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "swarm_masters" {
  ami           = data.aws_ami.ami-ubuntu.id
  associate_public_ip_address = true
  subnet_id = var.subnet-az-a
  instance_type = "t2.large"
  key_name      = var.key_pair_name
  count         = 3
  tags = {
    Name = "swarm-master-${count.index}-${var.meu_nome}"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 32
  }
  vpc_security_group_ids = [aws_security_group.acessos_masters.id]
  depends_on = [
    aws_instance.swarm_workers,
  ]
}

resource "aws_instance" "swarm_workers" {
  ami           = data.aws_ami.ami-ubuntu.id
  instance_type = "t2.medium"
  key_name      = var.key_pair_name
  associate_public_ip_address = true
  subnet_id = var.subnet-az-a
  count         = 3
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 32
  }
  tags = {
    Name = "swarm_workers-${count.index}-${var.meu_nome}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers.id]
}