terraform {
  required_version = ">= 0.14.9"

  backend "s3" {
    bucket = "devhalos-nihil-state"
    key    = "remote-backend/terraform.tfstate"
    region = "ap-southeast-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }
  }
}

