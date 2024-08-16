variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of IDs of public subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of IDs of private subnets"
  type        = list(string)
}

variable "private_route_table_ids" {
  description = "List of IDs of private route tables"
  type        = list(string)
}