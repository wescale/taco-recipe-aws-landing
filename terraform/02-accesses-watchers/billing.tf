module "watchers_billing_group" {
  source = "../mod_group_allowing_assume_role"

  group_name = "watchers-billing"

  allow_assume_prefixed_roles_in_accounts = [
    "${var.account_id_list["root"]}",
    "${var.account_id_list["sec"]}",
    "${var.account_id_list["dev"]}",
    "${var.account_id_list["rec"]}",
    "${var.account_id_list["pil"]}",
    "${var.account_id_list["prd"]}",
  ]

  members = "${var.memberlist_watchers_billing}"
}

# -----------------------------------------------------------------------------
# Role assumable by users, linked to root account
# -----------------------------------------------------------------------------
module "root_watchers_billing_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["root"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"

  tf_lock_dynamo_table = "${var.tf_lock_dynamo_table}"
  tfstate_bucket_name = "${var.tfstate_bucket_name}"

  allow_assume_prefixed_roles_in_accounts = [
    "${var.account_id_list["sec"]}",
    "${var.account_id_list["dev"]}",
    "${var.account_id_list["rec"]}",
    "${var.account_id_list["pil"]}",
    "${var.account_id_list["prd"]}",
  ]
}

# -----------------------------------------------------------------------------
# Role assumable by specified role, linked to target account
# root_account_id is used to mix with allow_roles names to generate assumed role
# ARNs.
# -----------------------------------------------------------------------------

provider "aws" {
  alias = "billing_sec"
  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["sec"]}:role/keepers-base"
  }
}
module "billing_watchers_sec_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["sec"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"

  tf_lock_dynamo_table = "${var.tf_lock_dynamo_table}"
  tfstate_bucket_name = "${var.tfstate_bucket_name}"

  providers {
    aws.module_local = "aws.billing_sec"
  }
}

provider "aws" {
  alias = "billing_dev"
  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["dev"]}:role/keepers-base"
  }
}
module "billing_watchers_dev_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["dev"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["dev"]}:role/keepers-base"

  tf_lock_dynamo_table = "${var.tf_lock_dynamo_table}"
  tfstate_bucket_name = "${var.tfstate_bucket_name}"

  providers {
    aws.module_local = "aws.billing_dev"
  }
}

provider "aws" {
  alias = "billing_rec"
  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["rec"]}:role/keepers-base"
  }
}
module "billing_watchers_rec_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["rec"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["rec"]}:role/keepers-base"

  tf_lock_dynamo_table = "${var.tf_lock_dynamo_table}"
  tfstate_bucket_name = "${var.tfstate_bucket_name}"

  providers {
    aws.module_local = "aws.billing_rec"
  }
}

provider "aws" {
  alias = "billing_pil"
  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["pil"]}:role/keepers-base"
  }
}
module "billing_watchers_pil_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["pil"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["pil"]}:role/keepers-base"

  tf_lock_dynamo_table = "${var.tf_lock_dynamo_table}"
  tfstate_bucket_name = "${var.tfstate_bucket_name}"

  providers {
    aws.module_local = "aws.billing_pil"
  }
}

provider "aws" {
  alias = "billing_prd"
  assume_role {
    session_name = "keepers-base"
    role_arn     = "arn:aws:iam::${var.account_id_list["prd"]}:role/keepers-base"
  }
}
module "billing_watchers_prd_role" {
  source            = "../mod_role_for_users"
  group_name        = "watchers-billing"
  role_name         = "base"
  root_account_id   = "${var.account_id_list["root"]}"
  target_account_id = "${var.account_id_list["prd"]}"
  template          = "${file("${path.module}/policies/watchers_billing.json")}"
  allow_users       = "${var.memberlist_watchers_billing}"
  run_as            = "arn:aws:iam::${var.account_id_list["prd"]}:role/keepers-base"

  tf_lock_dynamo_table = "${var.tf_lock_dynamo_table}"
  tfstate_bucket_name = "${var.tfstate_bucket_name}"

  providers {
    aws.module_local = "aws.billing_prd"
  }
}
