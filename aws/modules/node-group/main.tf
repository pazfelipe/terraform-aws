resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.node_group_name}-nodegroup"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  disk_size = var.disk_size

  scaling_config {
    desired_size = var.scaling_config.desired_size
    max_size     = var.scaling_config.max_size
    min_size     = var.scaling_config.min_size
  }

  update_config {
    max_unavailable = 1
  }

  ami_type = var.ami_type

  instance_types = var.instance_types
}
