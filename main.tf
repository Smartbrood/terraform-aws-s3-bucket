resource "aws_s3_bucket" "this" {
  bucket = "${var.s3_fqdn}"
  force_destroy = true
  tags = "${merge(var.tags, map("Name", format("%s", var.s3_fqdn)))}"
}

resource "aws_s3_bucket_policy" "private" {
  count  = "${var.allow_public ? 0 : 1}"
  bucket = "${aws_s3_bucket.this.id}"
  policy =<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Action": ["s3:*"],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::${var.s3_fqdn}",
                   "arn:aws:s3:::${var.s3_fqdn}/*"],
      "Principal": {
        "AWS": ["arn:aws:iam::${var.aws_account_id}:user/${var.aws_username}"]
      }
    }
  ]
}
EOF
}

resource "aws_s3_bucket_policy" "public" {
  count  = "${var.allow_public ? 1 : 0}"
  bucket = "${aws_s3_bucket.this.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Action": ["s3:*"],
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::${var.s3_fqdn}",
                   "arn:aws:s3:::${var.s3_fqdn}/*"],
      "Principal": {
        "AWS": ["arn:aws:iam::${var.aws_account_id}:user/${var.aws_username}"]
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
  count   = "${length(var.files)}"
  bucket  = "${aws_s3_bucket.this.id}"
  key     = "${element(keys(var.files), count.index)}"
  source  = "${lookup(var.files, element(keys(var.files), count.index))}"
  etag    = "${md5(file("${lookup(var.files, element(keys(var.files), count.index))}"))}"
}



