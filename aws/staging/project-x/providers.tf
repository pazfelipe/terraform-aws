terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
  }

  # Uncomment the line below if you would like to use a remote bucket to storage the tf state.

  # backend "s3" {
  #   bucket = "remote-s3-bucket"
  #   key    = "path/terraform.tfstate"
  #   region = "us-east-2"
  # }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority)
  token                  = module.eks.cluster_token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["--region", var.region, "eks", "get-token", "--cluster-name", module.eks.cluster_id]
    command     = "aws"
  }
}
