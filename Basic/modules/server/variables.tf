variable "region" {
  description = "Region"
  type        = string
  default     = "region"
}

variable "access_key" {
  description = "Access Key"
  type        = string
  default     = "access_key"
}

variable "secret_key" {
  description = "Secret Key"
  type        = string
  default     = "secret_key"
}

variable "bucket_name" {
  description = "Bucket Name"
  type        = string
  default     = "bucket_name"
}

variable "instance_image" {
  description = "Ubuntu, 22.04 LTS"
  type        = string
  default     = "ami_id"
}

variable "instance_name" {
  description = "Instance Name"
  type        = string
  default     = "instance_name"
}