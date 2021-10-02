provider "aws" {
  region = "us-east-1"
}

module "objects" {
  source = "./s3_object"

  for_each = var.files != "" ? fileset(var.files, "**") : []

  bucket = "UM BACKET"
  key    = "${var.key_prefix}/${each.value}"
  src    = "${var.files}/${each.value}"
}
