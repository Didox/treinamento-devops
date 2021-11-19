variable "vpc_id" {
  type = string
  description = "VPC ID."
}

variable "sg_front_object" {
  description = "Security group data for Frontend in Kubernetes environment."
  type = object({
      name = string
      description = string
  })
}

variable "sg_hproxy_object" {
  description = "Security group data for HPROXY in Kubernetes environment."
  type = object({
      name = string
      description = string
  })
}

variable "sg_master_object" {
  description = "Security group data for Master nodes in Kubernetes environment."
  type = object({
      name = string
      description = string
  })
}

variable "sg_worker_object" {
  description = "Security group data for Worker nodes in Kubernetes environment."
  type = object({
      name = string
      description = string
  })
}

variable "instance_k8s_front_object" {
  description = "Instance template data for Frontend in Kubernetes environment."
  type = object({
      name = string
      type = string
      key_pair = string
      iam_profile = string
      number_of_nodes = number
      public_ip = bool
  })
}

variable "instance_k8s_hproxy_object" {
  description = "Instance template data for HPROXY in Kubernetes environment."
  type = object({
      name = string
      type = string
      key_pair = string
      iam_profile = string
      number_of_nodes = number
      public_ip = bool
  })
}

variable "instance_k8s_master_object" {
  description = "Instance template data for Master nodes in Kubernetes environment."
  type = object({
      name = string
      type = string
      key_pair = string
      iam_profile = string
      number_of_nodes = number
      public_ip = bool
  })
}

variable "instance_k8s_worker_object" {
  description = "Instance template data for Worker nodes in Kubernetes environment."
  type = object({
      name = string
      type = string
      key_pair = string
      iam_profile = string
      number_of_nodes = number
      public_ip = bool
  })
}