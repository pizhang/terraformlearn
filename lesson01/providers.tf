terraform {
    required_version = "1.15.7"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "6.53.0"
        }
    }

    cloud {
        organization = "pizhang"

        workspaces {
            name = "associate004"
        }
    }    
}

provider "aws" {
    region = var.region
}