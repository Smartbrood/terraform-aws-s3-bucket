terraform-aws-s3-bucket
=======================

Terraform module to create S3 bucket on AWS


Example of Bucket with only private access
------------------------------------------

```hcl
module "s3_bucket" {
    source            = "Smartbrood/s3-bucket/aws"
    s3_fqdn           = var.s3_fqdn
    aws_account_id    = var.aws_account_id
    aws_username      = var.aws_username
    files             = var.files
    base64_files      = var.base64_files
    enable_versioning = var.enable_versioning

    tags = {
        Terraform   = "true"
        Environment = "stage"
        Project     = "my_project"
    }
}
```


Example of Bucket with read public access
-----------------------------------------

```hcl
module "s3_bucket" {
    source            = "Smartbrood/s3-bucket/aws"
    s3_fqdn           = var.s3_fqdn
    aws_account_id    = var.aws_account_id
    aws_username      = var.aws_username
    files             = var.files
    base64_files      = var.base64_files
    enable_versioning = var.enable_versioning

    allow_public   = "true"

    tags = {
        Terraform   = "true"
        Environment = "stage"
        Project     = "my_project"
    }
}
```


Authors
-------

Module managed by [Smartbrood LLC](https://github.com/Smartbrood).


License
-------

Apache 2 Licensed. See LICENSE for full details.
