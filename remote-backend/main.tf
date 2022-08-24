provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    organization = "devhalos"
    project      = "nihil"
    component    = "nihil-state"
  }
}

module "jenkins_casc" {
  source    = "github.com/devhalos/nihil-terraform-modules.git//aws_s3_remote_backend?ref=v0.1.0"
  component = "jenkins-casc-${terraform.workspace}"
}

