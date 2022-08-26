terraform {
  required_version = ">= 0.14.9"

  backend "s3" {
    bucket  = "devhalos-nihil-infra-state"
    key     = "cicd-pipeline-acl/terraform.tfstate"
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

