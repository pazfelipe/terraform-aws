variable cluster_name {
  description = "The name of the EKS cluster"
  type        = string
}

variable retention_in_days {
  description = "The number of days log events are kept in CloudWatch Logs"
  type        = number
  default     = 7
}