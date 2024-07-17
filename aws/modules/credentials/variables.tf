variable "region" {
  type        = string
  description = "Project's regions"
  default     = "us-east-2"
}

variable "access_key" {
  type        = string
  description = "Access key"
  default     = ""
}

variable "secret_key" {
  type        = string
  description = "Secret key"
  default     = ""
}