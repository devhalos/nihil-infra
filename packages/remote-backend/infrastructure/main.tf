provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = {
      organization = var.organization
      project      = var.project
      component    = var.component
    }
  }
}



