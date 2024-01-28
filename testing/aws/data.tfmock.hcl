mock_resource "aws_s3_bucket" {
  defaults = {
    id                          = "test_id"
    arn                         = "test_arn"
    bucket_domain_name          = "test_bucket_domain_name"
    bucket_regional_domain_name = "test_bucket_regional_domain_name"
    hosted_zone_id              = "test_hosted_zone_id"
    region                      = "test_region"
  }
}

mock_resource "aws_s3_bucket_ownership_controls" {
  defaults = {
    bucket = "test_id"
    rule = {
      object_ownership = "BucketOwnerEnforced"
    }
  }
}

mock_resource "aws_s3_bucket_versioning" {
  defaults = {
    bucket = "test_id"
    versioning_configuration = {
      status = "Disabled"
    }
  }
}
