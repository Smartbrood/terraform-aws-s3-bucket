variable "bucket" {
  description = "Name of the bucket."
  type        = string
}

variable "force_destroy" {
  description = "Boolean that indicates all objects should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of tags to assign to the bucket."
  type        = map(any)
  default = {

  }
}

variable "versioning_status" {
  description = "Versioning state of the bucket."
  type        = string
  default     = "Disabled"
}

variable "object_ownership" {
  description = "Versioning state of the bucket."
  type        = string
  default     = "BucketOwnerEnforced"
}
