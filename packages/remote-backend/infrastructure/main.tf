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

module "dyene_web_app" {
  source       = "../../terraform-modules/modules/aws_s3_remote_backend"
  organization = var.organization
  project      = var.project
  component    = "dyene-web-app"
}


