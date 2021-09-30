# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest#multiple-ec2-instance

module "multiple_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  monitoring             = true

  tags = {
    Terraform   = "true"
    Environment = "dev" 
  }
}