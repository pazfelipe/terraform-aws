variable "project_id" {
  type        = string
  description = "Project ID"
  default     = "project-x"
}

variable "region" {
  type        = string
  description = "Project region"
  default     = "us-east-2"
}

variable "zones" {
  type        = list(string)
  description = "Zones avaibility"
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
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

variable "ami_type" {
  default     = "AL2_x86_64"
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group"
}

variable "disk_size" {
  default     = 100
  description = "Disk size in GiB for worker nodes. Defaults to 50 for Windows, 20 all other node groups. Terraform will only perform drift detection if a configuration value is provided"
}

variable "instance_types" {
  default     = ["t3.medium"]
  description = "List of instance types associated with the EKS Node Group. Defaults to ['t3.medium']. Terraform will only perform drift detection if a configuration value is provided"
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

variable "destination_cidr_block" {
  description = "The CIDR block of the route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "scaling_config" {
  description = "Nested argument containing scaling configuration"
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
  default = {
    desired_size = 1
    max_size     = 50
    min_size     = 0
  }
}

variable "route_table_cidr_block" {
  description = "The CIDR block of the route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the route"
  type        = string
  default     = "11.32.0.0/20"
}

variable "eks_log_types" {
  type        = list(string)
  description = "A list of the desired control plane logging to enable"
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "retention_in_days" {
  description = "The number of days log events are kept in CloudWatch Logs"
  type        = number
  default     = 7
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_cluster_autoscaler" {
  description = "Determines whether to deploy cluster autoscaler"
  type        = bool
  default     = true
}

variable "cluster_autoscaler_helm_verion" {
  description = "Cluster Autoscaler Helm verion"
  type        = string
  default     = "cluster-autoscaler-release-1.27"
}

variable "eks_node_group_role" {
  description = "The name of the EKS node group role"
  type        = string
  default     = "AWSEKSNodeGroupRoleFor"
}

variable "iam_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "AWSEKS"
}