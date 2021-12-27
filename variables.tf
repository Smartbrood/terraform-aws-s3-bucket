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
  type        = map(any)
  default     = {}
}

variable "base64_files" {
  description = "map s3 keys to base64 encoded files"
  type        = map(any)
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

variable "create_logging_bucket" {
  description = "Create a logging bucket (will not create if `loggingBucket` is defined)"
  default     = true
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

variable "enable_versioning" {
  description = "Conditionally enable versioning"
  default     = false
}

variable "enable_default_server_side_encryption" {
  description = "Conditionally enable server side encryption by default"
  default     = false
}
