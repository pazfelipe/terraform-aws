variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the NAT gateway will be created"
  type        = string
}


variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_route_table_ids" {
  description = "IDs of the private route tables"
  type        = list(string)
}

variable "destination_cidr_block" {
  description = "The CIDR block of the route"
  type        = string
  default     = "0.0.0.0/0"
}
