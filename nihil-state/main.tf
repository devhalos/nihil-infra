provider "aws" {
  region = "ap-southeast-1"
}

module "jenkins_casc" {
  source    = "github.com/devhalos/nihil-terraform-modules.git//aws_s3_remote_backend?ref=v0.1.0"
  component = "jenkins-casc"
}

