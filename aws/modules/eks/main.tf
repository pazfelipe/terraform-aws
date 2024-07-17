resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.role_arn

  enabled_cluster_log_types = var.eks_log_types

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.id
}

resource "kubernetes_config_map" "aws-auth" {

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data       = var.aws_auth_configmap.data
  depends_on = [aws_eks_cluster.this]
}
