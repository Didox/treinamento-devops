variable "amis" {
  default = {
    "us-east-1-ubuntu18" = "ami-013f17f36f8b1fefb"
    "us-east-1-ubuntu20" = "ami-042e8287309f5df03"
    "us-east-2-ubuntu20" = "ami-08962a4068733a2b6"
  }
}

variable "instance_type" {
  default = {
    "micro" = "t2.micro"
  }
}
