variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "iam_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "eks_node_group_role" {
  description = "The name of the EKS node group role"
  type        = string
}