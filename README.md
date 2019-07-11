# Terraform Dynamic Bug

The project reproduces Terraform Dynamic Bug: *Provider produced inconsistent final plan v0.12.3*

## How to reproduce?

1. Clone the current repository
2. Prepare AWS enviroment

```
$ export AWS_SDK_LOAD_CONFIG=1
$ export AWS_PROFILE=xxx
```
3. Check Terraform version and initialize Terraform modules

```
$ terraform version
Terraform v0.12.3
+ provider.aws v2.19.0
+ provider.template v2.1.2

$ terraform init
Initializing modules...
- subnets in subnets
- vpc in vpc

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (terraform-providers/aws) 2.19.0...
- Downloading plugin for provider "template" (terraform-providers/template) 2.1.2...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

4. Generate and show an execution plan

```
$ terraform plan -out dynamic_bug.tfupdate
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.nlb1 will be created
  + resource "aws_eip" "nlb1" {
      + allocation_id     = (known after apply)
      + association_id    = (known after apply)
      + domain            = (known after apply)
      + id                = (known after apply)
      + instance          = (known after apply)
      + network_interface = (known after apply)
      + private_dns       = (known after apply)
      + private_ip        = (known after apply)
      + public_dns        = (known after apply)
      + public_ip         = (known after apply)
      + public_ipv4_pool  = (known after apply)
      + vpc               = true
    }

  # aws_eip.nlb2 will be created
  + resource "aws_eip" "nlb2" {
      + allocation_id     = (known after apply)
      + association_id    = (known after apply)
      + domain            = (known after apply)
      + id                = (known after apply)
      + instance          = (known after apply)
      + network_interface = (known after apply)
      + private_dns       = (known after apply)
      + private_ip        = (known after apply)
      + public_dns        = (known after apply)
      + public_ip         = (known after apply)
      + public_ipv4_pool  = (known after apply)
      + vpc               = true
    }

  # aws_lb.nlb will be created
  + resource "aws_lb" "nlb" {
      + arn                              = (known after apply)
      + arn_suffix                       = (known after apply)
      + dns_name                         = (known after apply)
      + enable_cross_zone_load_balancing = false
      + enable_deletion_protection       = false
      + id                               = (known after apply)
      + internal                         = false
      + ip_address_type                  = (known after apply)
      + load_balancer_type               = "network"
      + name                             = "nlb"
      + security_groups                  = (known after apply)
      + subnets                          = (known after apply)
      + vpc_id                           = (known after apply)
      + zone_id                          = (known after apply)

      + subnet_mapping {
          + allocation_id = (known after apply)
          + subnet_id     = (known after apply)
        }
    }

  # module.subnets.aws_subnet.public[0] will be created
  + resource "aws_subnet" "public" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.10.1.128/26"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # module.subnets.aws_subnet.public[1] will be created
  + resource "aws_subnet" "public" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-1b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.10.1.192/26"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + vpc_id                          = (known after apply)
    }

  # module.vpc.aws_internet_gateway.default will be created
  + resource "aws_internet_gateway" "default" {
      + id       = (known after apply)
      + owner_id = (known after apply)
      + vpc_id   = (known after apply)
    }

  # module.vpc.aws_route.internet_access will be created
  + resource "aws_route" "internet_access" {
      + destination_cidr_block     = "0.0.0.0/0"
      + destination_prefix_list_id = (known after apply)
      + egress_only_gateway_id     = (known after apply)
      + gateway_id                 = (known after apply)
      + id                         = (known after apply)
      + instance_id                = (known after apply)
      + instance_owner_id          = (known after apply)
      + nat_gateway_id             = (known after apply)
      + network_interface_id       = (known after apply)
      + origin                     = (known after apply)
      + route_table_id             = (known after apply)
      + state                      = (known after apply)
    }

  # module.vpc.aws_vpc.default will be created
  + resource "aws_vpc" "default" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.10.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = (known after apply)
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
    }

Plan: 8 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: dynamic_bug.tfupdate

To perform exactly these actions, run the following command to apply:
    terraform apply "dynamic_bug.tfupdate"
```

5. Builds Infrastructure

```
$ terraform apply dynamic_bug.tfupdate
aws_eip.nlb2: Creating...
aws_eip.nlb1: Creating...
module.vpc.aws_vpc.default: Creating...
aws_eip.nlb2: Creation complete after 1s [id=eipalloc-0a156xxxxxxxxxxxx]
aws_eip.nlb1: Creation complete after 1s [id=eipalloc-0baf1xxxxxxxxxxxx]
module.vpc.aws_vpc.default: Creation complete after 5s [id=vpc-0ef6axxxxxxxxxxxx]
module.vpc.aws_internet_gateway.default: Creating...
module.subnets.aws_subnet.public[1]: Creating...
module.subnets.aws_subnet.public[0]: Creating...
module.subnets.aws_subnet.public[0]: Creation complete after 1s [id=subnet-0e33bxxxxxxxxxxxx]
module.subnets.aws_subnet.public[1]: Creation complete after 1s [id=subnet-08105xxxxxxxxxxxx]
module.vpc.aws_internet_gateway.default: Creation complete after 2s [id=igw-0d2aaxxxxxxxxxxxxxx]
module.vpc.aws_route.internet_access: Creating...
module.vpc.aws_route.internet_access: Creation complete after 1s [id=r-rtb-096exxxxxxxxxxxxxxxxxxxxxxx]
> Error: Provider produced inconsistent final plan
>
> When expanding the plan for aws_lb.nlb to include new values learned so far
> during apply, provider "aws" produced an invalid new value for
> .subnet_mapping: block set length changed from 1 to 2.
>
> This is a bug in the provider, which should be reported in the provider's own
> issue tracker.*
```

See the error message above. But if we run the `plan` and `apply` commands again, then everything will work.

```
$ terraform plan -out dynamic_bug_second_pass.tfupdate
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_eip.nlb1: Refreshing state... [id=eipalloc-0baf1xxxxxxxxxxxx]
aws_eip.nlb2: Refreshing state... [id=eipalloc-0a156xxxxxxxxxxxx]
module.vpc.aws_vpc.default: Refreshing state... [id=vpc-0ef6axxxxxxxxxxxx]
module.vpc.aws_internet_gateway.default: Refreshing state... [id=igw-0d2aaxxxxxxxxxxxxxx]
module.subnets.aws_subnet.public[1]: Refreshing state... [id=subnet-08105xxxxxxxxxxxx]
module.subnets.aws_subnet.public[0]: Refreshing state... [id=subnet-0e33bxxxxxxxxxxxx]
module.vpc.aws_route.internet_access: Refreshing state... [id=r-rtb-096exxxxxxxxxxxxxxxxxxxxxxx]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_lb.nlb will be created
  + resource "aws_lb" "nlb" {
      + arn                              = (known after apply)
      + arn_suffix                       = (known after apply)
      + dns_name                         = (known after apply)
      + enable_cross_zone_load_balancing = false
      + enable_deletion_protection       = false
      + id                               = (known after apply)
      + internal                         = false
      + ip_address_type                  = (known after apply)
      + load_balancer_type               = "network"
      + name                             = "nlb"
      + security_groups                  = (known after apply)
      + subnets                          = (known after apply)
      + vpc_id                           = (known after apply)
      + zone_id                          = (known after apply)

      + subnet_mapping {
          + allocation_id = "eipalloc-0a156xxxxxxxxxxxx"
          + subnet_id     = "subnet-08105xxxxxxxxxxxx"
        }
      + subnet_mapping {
          + allocation_id = "eipalloc-0baf1xxxxxxxxxxxx"
          + subnet_id     = "subnet-0e33bxxxxxxxxxxxx"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: dynamic_bug_second_pass.tfupdate

To perform exactly these actions, run the following command to apply:
    terraform apply "dynamic_bug_second_pass.tfupdate"

$ terraform apply dynamic_bug_second_pass.tfupdate
aws_lb.nlb: Creating...
aws_lb.nlb: Still creating... [10s elapsed]
...
aws_lb.nlb: Still creating... [2m30s elapsed]
aws_lb.nlb: Creation complete after 2m37s [id=arn:aws:elasticloadbalancing:us-east-1:xxxxxxxxxxxx:loadbalancer/net/nlb/31b2xxxxxxxxxxxx]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate
```

6. Lets make sure that we do not have any more changes.

```
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_eip.nlb1: Refreshing state... [id=eipalloc-0baf1xxxxxxxxxxxx]
aws_eip.nlb2: Refreshing state... [id=eipalloc-0a156xxxxxxxxxxxx]
module.vpc.aws_vpc.default: Refreshing state... [id=vpc-0ef6axxxxxxxxxxxx]
module.vpc.aws_internet_gateway.default: Refreshing state... [id=igw-0d2aaxxxxxxxxxxxxxx]
module.subnets.aws_subnet.public[1]: Refreshing state... [id=subnet-08105xxxxxxxxxxxx]
module.subnets.aws_subnet.public[0]: Refreshing state... [id=subnet-0e33bxxxxxxxxxxxx]
module.vpc.aws_route.internet_access: Refreshing state... [id=r-rtb-096exxxxxxxxxxxxxxxxxxxxxxx]
aws_lb.nlb: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:xxxxxxxxxxxx:loadbalancer/net/nlb/31b2xxxxxxxxxxxx]

------------------------------------------------------------------------

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.

```
