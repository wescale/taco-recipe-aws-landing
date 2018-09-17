# T.A.C.O. Recipe: AWS Landing

## Where am I ?

This repository contains Terraform code for landing on the AWS planet.
Every step that I had to do at least twice for different business context
are here automated. That includes:

* The very first action after creating an AWS account.
* Creating the first IAM administrator.
* Setting up a coherent AWS Organization.
* Setting up a KMS cyphered S3 Bucket for Terraform to store its tfstates.
* Creating VPC and subnets in every account.
* Peering them efficiently for having one account hosting shared services.
* Setting up Cloudtrail and AWS Config on every account, and centralizing
collected data in S3 Bucket of a single account.
* Creating a coherent user access logic.

This codebase is written to integrate with the [T.A.C.O. Project toolkit](https://wescale.github.io/taco-project/).

There is a lot of code here. I did my best to document but _Code is Truth_. Have fun.

## Procedure to land on the AWS planet

### AWS account creation

* Create an account and connect a the root user.
* Create a support ticket with these values:
    * _Limit increase request_
    * _Service:_ Organizations
    * _Limit name:_ Number of Accounts
    * _New limit value:_ 10
    
Do not forget to put a kind message for support team in your ticket, they do a great job.

* Create a new file `terraform/all-layers.yml` and fill it like this:

```
---
# This is a short label with only alphanumeric.
# It will be use to prefix every AWS account of your organization.
basename: "taco"

# The email you used for creating the account one first step.
root_email: "your_root@email"

# The main region you will be operating from for this deployment.
main_region: "eu-west-1"
```

### Create first administrator

* Create an access key and a secret key for your root user.
* Source them in a terminal and run:

```
make first_admin
make append_first_admin_name_to_taco_vars
```

### Create organization

* Create an access key and a secret key *for the first admin account*
* Source them in a terminal and run:

```
make organization
make append_organization_to_taco_vars
```

### Create a backend for tfstates

```
make tfbackend
make append_backend_conf_to_taco_vars
make move_first_admin_backend
make move_organization_backend
make move_tfbackend_backend
```

## Coming soon in this documentation

* User creation procedure
* The user tribes
* How to work efficiently as a tribe member
* Network landscape
* Nat
* Peering

TODO
* exercice 3 le coup des 10m sur taint