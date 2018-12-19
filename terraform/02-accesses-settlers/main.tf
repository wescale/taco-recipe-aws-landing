# -----------------------------------------------------------------------------
# Group that allow users to assume roles named like "${group_name}-*" in
# specified accounts
# -----------------------------------------------------------------------------
module "settlers_base_group" {
  source = "../mod_group_allowing_assume_role"

  group_name = "settlers"

  allow_assume_prefixed_roles_in_accounts = [
    "${values(var.account_id_list)}",
  ]

  members = "${var.memberlist_settlers_base}"
}

# -----------------------------------------------------------------------------
# Role assumable by users, linked to root account
# -----------------------------------------------------------------------------
module "root_settlers_base_role" {
  source = "../mod_role_for_users"

  group_name = "settlers"
  role_name  = "base"

  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["root"]}"

  template    = "${file("${path.module}/policies/settlers_base.json")}"
  allow_users = "${var.memberlist_settlers_base}"

  allow_assume_prefixed_roles_in_accounts = [
    "${var.account_id_list["sec"]}",
    "${var.account_id_list["dev"]}",
    "${var.account_id_list["rec"]}",
    "${var.account_id_list["pil"]}",
    "${var.account_id_list["prd"]}",
  ]

  tfstate_bucket_name = "${var.tfstate_bucket_name}"
  tfstate_kms_key_arn = "${var.tfstate_kms_key_arn}"
  tf_lock_dynamo_table = "${var.tf_lock_dynamo_table}"
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# root_account_id is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------

provider "aws" {
  alias = "sec"

  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["sec"]}:role/keepers-base"
  }
}
module "sec_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["sec"]}"
  organization_role_name = "${var.organization_role_name}"

  providers {
    aws = "aws.sec"
  }
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# root_account_id is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------

provider "aws" {
  alias = "dev"

  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["dev"]}:role/keepers-base"
  }
}
module "dev_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["dev"]}"
  organization_role_name = "${var.organization_role_name}"

  providers {
    aws = "aws.dev"
  }
}

provider "aws" {
  alias = "rec"

  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["rec"]}:role/keepers-base"
  }
}
module "rec_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["rec"]}"
  organization_role_name = "${var.organization_role_name}"

  providers {
    aws = "aws.rec"
  }
}

provider "aws" {
  alias = "pil"

  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["pil"]}:role/keepers-base"
  }
}
module "pil_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["pil"]}"
  organization_role_name = "${var.organization_role_name}"

  providers {
    aws = "aws.pil"
  }
}

provider "aws" {
  alias = "prd"

  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["prd"]}:role/keepers-base"
  }
}
module "prd_settlers_base_role" {
  source = "../mod_role_for_roles"

  group_name = "settlers"
  role_name  = "base"

  root_account_id = "${var.account_id_list["root"]}"

  template = "${file("${path.module}/policies/settlers_sub.json")}"

  allow_roles = [
    "${module.root_settlers_base_role.role_name}",
  ]

  target_account_id      = "${var.account_id_list["prd"]}"
  organization_role_name = "${var.organization_role_name}"

  providers {
    aws = "aws.prd"
  }
}
