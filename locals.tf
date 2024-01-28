locals {
  tags = merge(var.tags, {
    Terraform = true
    Module    = "Smartbrood/terraform-aws-s3-bucket"
  })
}
