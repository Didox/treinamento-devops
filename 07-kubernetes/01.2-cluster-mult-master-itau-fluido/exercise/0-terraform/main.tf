provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "levb_k8s_front" {
  count         = var.instance_k8s_front_object.number_of_nodes
  # ami                         = data.aws_ami.ubuntu.image_id
  ami           = "ami-09c92d3eb1db3a728"
  instance_type = var.instance_k8s_front_object.type
  key_name      = var.instance_k8s_front_object.key_pair
  # iam_instance_profile        = var.instance_k8s_front_object.iam_profile
  associate_public_ip_address = var.instance_k8s_front_object.public_ip

  vpc_security_group_ids = [aws_security_group.sg_k8s_front.id]
  subnet_id              = data.aws_subnets.vpc_public_subnets.ids[((count.index) % 3)]

  ebs_optimized = true
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 32
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Name = "${var.instance_k8s_front_object.name}-${count.index}"
  }
}

resource "aws_instance" "levb_k8s_hproxy" {
  count         = var.instance_k8s_hproxy_object.number_of_nodes
  # ami                         = data.aws_ami.ubuntu.image_id
  ami           = "ami-09c92d3eb1db3a728"
  instance_type = var.instance_k8s_hproxy_object.type
  key_name      = var.instance_k8s_hproxy_object.key_pair
  # iam_instance_profile        = var.instance_k8s_hproxy_object.iam_profile
  associate_public_ip_address = var.instance_k8s_hproxy_object.public_ip

  vpc_security_group_ids = [aws_security_group.sg_k8s_hproxy.id]
  subnet_id              = data.aws_subnets.vpc_public_subnets.ids[((count.index) % 3)]

  ebs_optimized = true
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 32
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Name = "${var.instance_k8s_hproxy_object.name}-${count.index}"
  }
}
resource "aws_instance" "levb_k8s_master" {
  count         = var.instance_k8s_master_object.number_of_nodes
  # ami                         = data.aws_ami.ubuntu.image_id
  ami           = "ami-09c92d3eb1db3a728"
  instance_type = var.instance_k8s_master_object.type
  key_name      = var.instance_k8s_master_object.key_pair
  # iam_instance_profile        = var.instance_k8s_master_object.iam_profile
  associate_public_ip_address = var.instance_k8s_master_object.public_ip

  vpc_security_group_ids = [aws_security_group.sg_k8s_master.id]
  subnet_id              = data.aws_subnets.vpc_public_subnets.ids[((count.index) % 3)]

  ebs_optimized = true
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 32
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Name = "${var.instance_k8s_master_object.name}-${count.index}"
  }
  depends_on = [
    aws_instance.levb_k8s_worker
  ]
}

resource "aws_instance" "levb_k8s_worker" {
  count = var.instance_k8s_worker_object.number_of_nodes
  # ami                         = data.aws_ami.ubuntu.image_id
  ami           = "ami-09c92d3eb1db3a728"
  instance_type = var.instance_k8s_worker_object.type
  key_name      = var.instance_k8s_worker_object.key_pair
  # iam_instance_profile        = var.instance_k8s_master_object.iam_profile
  associate_public_ip_address = var.instance_k8s_worker_object.public_ip

  vpc_security_group_ids = [aws_security_group.sg_k8s_worker.id]
  subnet_id              = data.aws_subnets.vpc_public_subnets.ids[((count.index) % 3)]

  ebs_optimized = true
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 24
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  tags = {
    Name = "${var.instance_k8s_worker_object.name}-${count.index}"
  }
}
