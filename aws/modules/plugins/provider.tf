provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["--region", var.region, "eks", "get-token", "--cluster-name", var.cluster_id]
      command     = "aws"
    }
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate)
  token = var.cluster_token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["--region", var.region, "eks", "get-token", "--cluster-name", var.cluster_id]
    command     = "aws"
  }
}
