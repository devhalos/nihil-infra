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

module "jenkins_casc" {
  source    = "github.com/devhalos/nihil-terraform-modules.git//aws_s3_remote_backend?ref=v0.2.0"
  component = "${var.component}-jenkins-casc"
}

module "jenkins_casc_image" {
  source    = "github.com/devhalos/nihil-terraform-modules.git//aws_s3_remote_backend?ref=v0.2.0"
  component = "${var.component}-jenkins-casc-image"
}

module "piso_wifi" {
  source    = "github.com/devhalos/nihil-terraform-modules.git//aws_s3_remote_backend?ref=v0.2.0"
  component = "${var.component}-piso-wifi"
}


