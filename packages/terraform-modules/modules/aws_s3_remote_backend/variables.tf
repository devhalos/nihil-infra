variable "organization" {
  description = "name of the organization"
  type        = string
  default     = "devhalos"
}

variable "project" {
  description = "name of the project"
  type        = string
  default     = "nihil"
}

variable "component" {
  description = "name of the component"
  type        = string
}

variable "tags" {
  description = "tags that resources relates to"
  type        = map(string)
  default     = {}
}
