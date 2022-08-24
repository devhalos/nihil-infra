variable "aws_account" {
  type = string
}

variable "organization" {
  type    = string
  default = "devhalos"
}

variable "project" {
  type    = string
  default = "nihil"
}

variable "component" {
  type    = string
  default = "cicd-pipeline-acl"
}
