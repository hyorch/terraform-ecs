# S3 backend configuration
terraform {
  backend "s3" {
    bucket  = "hyorch-terraform"
    key     = "terraform-ecs/state"
    region  = "eu-south-2"
    profile = "HyorchAdmin"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
