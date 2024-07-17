output "node_group_arn" {
  description = "The Amazon Resource Name (ARN) of the EKS Node Group"
  value       = aws_eks_node_group.this.arn
}

output "node_group_id" {
  description = "The EKS Node Group ID"
  value       = aws_eks_node_group.this.id
}

output "node_group_name" {
  description = "The EKS Node Group name"
  value       = aws_eks_node_group.this.node_group_name
}