terraform {
  required_version = ">= 1.5.7"

  backend "s3" {
    bucket         = "devhalos-nihil-infra-state"
    dynamodb_table = "devhalos-nihil-infra-state-locking"
    key            = "cicd-pipeline-acl/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
  }
}

