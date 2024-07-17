output "kube_config" {
  description = "The contents of the kubeconfig YAML file"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"
}
