variable "requester_env" {
  type = "string"
}

variable "requester_vpc_id" {
  type = "string"
}

variable "requester_private_route_table_list" {
  type = "list"
}

variable "accepter_private_route_table_list" {
  type = "list"
}

variable "accepter_main_route_table" {
  type = "string"
}

variable "accepter_cidr_block" {
  type = "string"
}

variable "accepter_env" {
  type = "string"
}

variable "accepter_vpc_id" {}

variable "requester_cidr_block" {}

provider "aws" {
  alias = "accepter"
}

data "aws_caller_identity" "accepter" {
  provider = "aws.accepter"
}
