variable "s3_fqdn" {
  description = "fqdn for s3 bucket"
}

variable "aws_account_id" {
  description = "AWS Account Id"
}

variable "aws_username" {
  description = "AWS Username"
}

variable "files" {
  description = "map s3 keys to files"
  type = "map"
}




