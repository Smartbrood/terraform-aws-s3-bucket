locals {
  defaultLoggingBucket = "${var.s3_fqdn}-bucket-log"
}

resource "aws_s3_bucket" "bucket_log" {
  count  = var.loggingBucket == "" && var.create_logging_bucket && var.create_bucket ? 1 : 0
  bucket = local.defaultLoggingBucket
  acl    = "log-delivery-write"

  tags = {
    name = "LoggingBucket"
  }
}

resource "aws_s3_bucket" "this" {
  count         = var.create_bucket ? 1 : 0
  bucket        = var.s3_fqdn
  force_destroy = true
  tags          = merge(var.tags, tomap({"Name" = format("%s", var.s3_fqdn)}))

  dynamic "logging" {
    for_each = var.create_logging_bucket == true ? [1] : []
    content {
      target_bucket = var.loggingBucket != "" ? var.loggingBucket : local.defaultLoggingBucket
      target_prefix = "log/"
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.enable_default_server_side_encryption == true ? [1] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "aws:kms"
        }
      }
    }
  }

  versioning {
    enabled = var.enable_versioning
  }
}

resource "aws_s3_bucket_policy" "private" {
  count  = var.allow_public != true && var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::${var.s3_fqdn}",
                   "arn:aws:s3:::${var.s3_fqdn}/*"],
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_id}:user/${var.aws_username}"
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "public" {
  count  = var.allow_public && var.create_bucket ? 1 : 0
  bucket = aws_s3_bucket.this[0].id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::${var.s3_fqdn}",
                   "arn:aws:s3:::${var.s3_fqdn}/*"],
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_id}:user/${var.aws_username}"
      }
    },
    {
      "Sid": "",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::${var.s3_fqdn}",
                   "arn:aws:s3:::${var.s3_fqdn}/*"],
      "Principal": {
        "AWS": "*"
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_object" "file" {
  count  = var.upload_files ? length(var.files) : 0
  bucket = var.s3_fqdn
  key    = element(keys(var.files), count.index)
  source = lookup(var.files, element(keys(var.files), count.index))
  etag   = md5(file(lookup(var.files, element(keys(var.files), count.index))))
}

resource "aws_s3_bucket_object" "base64_file" {
  count          = var.upload_files ? length(var.base64_files) : 0
  bucket         = var.s3_fqdn
  key            = element(keys(var.base64_files), count.index)
  content_base64 = lookup(var.base64_files, element(keys(var.base64_files), count.index))
}
