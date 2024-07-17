variable "node_group_name" {
  description = "The name of the node group"
  type        = string
}

variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
  type        = string
}

variable "instance_types" {
  description = "List of instance types associated with the EKS Node Group"
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "ARN of the IAM role for the EKS nodes"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS Node Group"
  type        = list(string)
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
}

variable "scaling_config" {
  description = "Nested argument containing scaling configuration"
  type        = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
  default = {
    desired_size = 1 
    max_size     = 1
    min_size     = 1
  }
}
