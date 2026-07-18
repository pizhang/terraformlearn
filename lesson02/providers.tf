terraform {
  required_version = ">= 1.15.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.53.0"
    }
  }

  # HCP Terraform Cloud configuration
  cloud {
    organization = "pizhang"

    workspaces {
      name = "associate004"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project
      Owner       = var.owner
      Terraform   = "true"
    }
  }
}