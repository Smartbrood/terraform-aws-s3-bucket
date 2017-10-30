resource "aws_s3_bucket" "this" {
  bucket = "${var.s3_fqdn}"
  force_destroy = true
  tags = "${merge(var.tags, map("Name", format("%s", var.s3_fqdn)))}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": ["arn:aws:iam::${var.aws_account_id}:user/${var.aws_username}"]
      },
      "Action": ["s3:*"],
      "Resource": ["arn:aws:s3:::${var.s3_fqdn}",
                   "arn:aws:s3:::${var.s3_fqdn}/*"]
    }
  ]
}
EOF
}

resource "aws_s3_bucket_object" "file" {
  count   = "${length(var.files)}"
  bucket  = "${aws_s3_bucket.this.id}"
  key     = "${element(keys(var.files), count.index)}"
  source  = "${lookup(var.files, element(keys(var.files), count.index))}"
  etag    = "${md5(file("${lookup(var.files, element(keys(var.files), count.index))}"))}"
}
