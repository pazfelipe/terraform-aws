variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "role_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role that provides permissions for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "eks_log_types" {
  type        = list(string)
  description = "A list of the desired control plane logging to enable"
  default     = []
}

variable "aws_auth_configmap" {
  type = object({
    data = map(string)
  })
  description = "The data for the aws-auth ConfigMap"
}