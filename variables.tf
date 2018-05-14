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
  type        = "map"
  default     = {}
}

variable "base64_files" {
  description = "map s3 keys to base64 encoded files"
  type        = "map"
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to bucket"
  default     = {}
}

variable "allow_public" {
  description = "Allow public read access to bucket"
  default     = false
}

variable "loggingBucket" {
  description = "The bucket you want to log S3 access to."
  default     = ""
}

variable "create_bucket" {
  description = "Conditionally create S3 bucket"
  default     = true
}

variable "upload_files" {
  description = "Conditionally upload files"
  default     = true
}
