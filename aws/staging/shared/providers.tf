terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.52"
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
  region = "us-east-2"

}