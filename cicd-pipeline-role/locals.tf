locals {
  component_name = "${var.organization}-${var.project}-${var.component}"

  common_tags = {
    organization = var.organization,
    project      = var.project
    component    = var.component
  }
}
