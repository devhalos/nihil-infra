terraform {
  required_version = ">= 1.6.2"

  backend "s3" {
    bucket         = "devhalos-nihil-infra-state"
    dynamodb_table = "devhalos-nihil-infra-state-locking"
    key            = "remote-backend/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.21.0"
    }
  }
}

