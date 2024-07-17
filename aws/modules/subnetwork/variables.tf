variable "zones" {
  description = "List of availability zones where the subnet will be created"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "vpc_id" {
  description = "The ID of the VPC where the subnets will be created"
  type        = string
}

variable "public_tags" {
  description = "Tags to be applied to the public subnets"
  type        = map(string)
  default     = null
}

variable "private_tags" {
  description = "Tags to be applied to the public subnets"
  type        = map(string)
  default     = null
}

variable "public_cidr_block" {
  description = "The CIDR block for the public subnets"
  type        = string
}

variable "private_cidr_block" {
  description = "The CIDR block for the private subnets"
  type        = string
}
