variable "vpc_cidr" {}

variable "region" {}

variable "az_list" {
  type    = "list"
  default = []
}

variable "environment" {}
variable "owner" {}
variable "stack" {}
variable "cost" {}
