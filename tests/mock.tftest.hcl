mock_provider "aws" {
  alias  = "fake"
  source = "./testing/aws"
}

run "mock" {

  command = apply

  providers = {
    aws = aws.fake
  }

  assert {
    condition     = output.id == "test_id"
    error_message = "Wrong id in output"
  }

  assert {
    condition     = output.arn == "test_arn"
    error_message = "Wrong arn in output"
  }

  assert {
    condition     = output.bucket_domain_name == "test_bucket_domain_name"
    error_message = "Wrong bucket_domain_name in output"
  }

  assert {
    condition     = output.bucket_regional_domain_name == "test_bucket_regional_domain_name"
    error_message = "Wrong bucket_regional_domain_name in output"
  }

  assert {
    condition     = output.hosted_zone_id == "test_hosted_zone_id"
    error_message = "Wrong hosted_zone_id in output"
  }

  assert {
    condition     = output.region == "test_region"
    error_message = "Wrong region in output"
  }

  assert {
    condition     = aws_s3_bucket.this.force_destroy == false
    error_message = "Error in aws_s3_bucket.this.force_destroy"
  }

  assert {
    condition     = aws_s3_bucket_ownership_controls.this.rule[0].object_ownership == "BucketOwnerEnforced"
    error_message = "Error in aws_s3_bucket_ownership_controls.this.rule.object_ownership"
  }

  assert {
    condition     = aws_s3_bucket_versioning.this.versioning_configuration[0].status == "Disabled"
    error_message = "Error in aws_s3_bucket_versioning.this.versioning_configuration.status"
  }
}
