output "cluster_id" {
  description = "The EKS Cluster ID"
  value       = aws_eks_cluster.this.id
}

output "cluster_name" {
  description = "The EKS Cluster ID"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the EKS Cluster"
  value       = aws_eks_cluster.this.arn
}

output "cluster_certificate_authority" {
  description = "The base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.this.certificate_authority.0.data
}

output identity_oidc_issuer {
  description = "IAM Openid Connect Provider ARN"
  value       = aws_eks_cluster.this.identity.0.oidc.0.issuer
}

output cluster_token {
  description = "Cluster token"
  value       = data.aws_eks_cluster_auth.this.token
}