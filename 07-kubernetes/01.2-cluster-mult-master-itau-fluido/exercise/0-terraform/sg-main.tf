resource "aws_security_group" "sg_k8s_front" {
  name        = var.sg_front_object.name
  description = var.sg_front_object.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_front_object.name
  }
}

resource "aws_security_group" "sg_k8s_hproxy" {
  name        = var.sg_hproxy_object.name
  description = var.sg_hproxy_object.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_hproxy_object.name
  }
}

resource "aws_security_group" "sg_k8s_master" {
  name        = var.sg_master_object.name
  description = var.sg_master_object.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_master_object.name
  }
}


resource "aws_security_group" "sg_k8s_worker" {
  name        = var.sg_worker_object.name
  description = var.sg_worker_object.description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_worker_object.name
  }
}
