terraform {
  required_version = ">= 0.14.9"

  backend "s3" {
    bucket  = "devhalos-nihil-state"
    key     = "github-actions/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.75.1"
    }
  }
}

