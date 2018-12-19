variable "root_account_id" {
  type = "string"
}

variable "target_account_id" {
  type = "string"
}

variable "organization_role_name" {
  type = "string"
}

variable "template" {}

variable "group_name" {}

variable "role_name" {}

variable "allow_roles" {
  type = "list"
}

variable "allow_roles_arn" {
  type    = "list"
  default = []
}

data "aws_region" "region" {}