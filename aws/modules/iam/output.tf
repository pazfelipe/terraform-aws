output "role_name" {
  description = "The name of the IAM role for the EKS cluster"
  value       = aws_iam_role.this.name
}

output "iam_role_arn" {
  description = "value of the IAM role for the EKS cluster"
  value = aws_iam_role.this.arn
}

output "eks_ng_role_name" {
  description = "The name of the IAM role for the EKS node group"
  value       = aws_iam_role.eks-ng.name
}

output "iam_role_eks_ng_arn" {
  description = "The ARN of the IAM role for the node group"
  value       = aws_iam_role.eks-ng.arn
}

output "iam_role_eks_policy_id" {
  description = "The ARN of the IAM role for the node group"
  value       = aws_iam_role_policy_attachment.this-AmazonEKSClusterPolicy.id
}
