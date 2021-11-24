resource "aws_security_group_rule" "front_k8s_ingress_ssh" {
  type              = "ingress"
  description       = "SG rule allowing access to SSH for Kubernetes Frontend SG."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_front.id
}

resource "aws_security_group_rule" "front_k8s_ingress_http" {
  type              = "ingress"
  description       = "SG rule allowing access to HTTP for Kubernetes Frontend SG."
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_front.id
}

resource "aws_security_group_rule" "front_k8s_ingress_https" {
  type              = "ingress"
  description       = "SG rule allowing access to HTTPS for Kubernetes Frontend SG."
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  # source_security_group_id = aws_security_group.sg_k8s_front.id
  security_group_id = aws_security_group.sg_k8s_front.id
}

resource "aws_security_group_rule" "front_k8s_egress_all" {
  type              = "egress"
  description       = "SG rule allowing access to external networks and Internet for Kubernetes Frontend SG."
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_front.id
}

resource "aws_security_group_rule" "hproxy_k8s_ingress_ssh" {
  type              = "ingress"
  description       = "SG rule allowing access to SSH for HPROXY SG."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_hproxy.id
}

resource "aws_security_group_rule" "hproxy_k8s_ingress_masters" {
  type             = "ingress"
  description      = "SG rule allowing masters SG to access HPROXY SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.sg_k8s_master.id
  security_group_id = aws_security_group.sg_k8s_hproxy.id
}

resource "aws_security_group_rule" "hproxy_k8s_ingress_workers" {
  type             = "ingress"
  description      = "SG rule allowing workers SG to access HPROXY SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.sg_k8s_worker.id
  security_group_id = aws_security_group.sg_k8s_hproxy.id
}

resource "aws_security_group_rule" "hproxy_k8s_egress_all" {
  type              = "egress"
  description       = "SG rule allowing access to external networks and Internet for HPROXY SG."
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_hproxy.id
}

resource "aws_security_group_rule" "master_k8s_ingress_ssh" {
  type              = "ingress"
  description       = "SG rule allowing access to SSH for Master SG."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_master.id
}

resource "aws_security_group_rule" "master_k8s_ingress_frontend" {
  type             = "ingress"
  description      = "SG rule allowing Frontend SG to access Master SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.sg_k8s_front.id
  security_group_id = aws_security_group.sg_k8s_master.id
}

# resource "aws_security_group_rule" "master_k8s_ingress_workers" {
#   type              = "ingress"
#   description       = "SG rule allowing Workers SG to access Master SG."
#   from_port         = 0
#   to_port           = 0
#   protocol          = "all"
#   cidr_blocks       = ["0.0.0.0/0"]
#   ipv6_cidr_blocks  = ["::/0"]
#     source_security_group_id = [
#     aws_security_group.sg_k8s_worker.id
#   ] 
#   security_group_id = aws_security_group.sg_k8s_master.id
# }

resource "aws_security_group_rule" "master_k8s_ingress_hproxy" {
  type             = "ingress"
  description      = "SG rule allowing HPROXY SG to access Master SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.sg_k8s_hproxy.id
  security_group_id = aws_security_group.sg_k8s_master.id
}

resource "aws_security_group_rule" "master_k8s_egress_all" {
  type              = "egress"
  description       = "SG rule allowing access to external networks and Internet for Master SG."
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_master.id
}

resource "aws_security_group_rule" "worker_k8s_ingress_ssh" {
  type              = "ingress"
  description       = "SG rule allowing access to SSH for Master SG."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_worker.id
}


resource "aws_security_group_rule" "worker_k8s_ingress_masters" {
  type             = "ingress"
  description      = "SG rule allowing Master SG to access Worker SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.sg_k8s_worker.id
  security_group_id = aws_security_group.sg_k8s_worker.id
}

resource "aws_security_group_rule" "worker_k8s_ingress_hproxy" {
  type             = "ingress"
  description      = "SG rule allowing HPROXY SG to access Worker SG."
  from_port        = 0
  to_port          = 0
  protocol         = "all"
  source_security_group_id = aws_security_group.sg_k8s_hproxy.id
  security_group_id = aws_security_group.sg_k8s_worker.id
}

resource "aws_security_group_rule" "worker_k8s_egress_all" {
  type              = "egress"
  description       = "SG rule allowing access to external networks and Internet for Worker SG."
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.sg_k8s_worker.id
}
