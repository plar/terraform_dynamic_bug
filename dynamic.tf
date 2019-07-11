# AWS provider
provider "template" {
  version = "~> 2.1"
}

provider "aws" {
  version = "~> 2.18"
  region  = "us-east-1"
}


# vpc and subnets
module "vpc" {
  source = "./vpc/"
}

module "subnets" {
  source = "./subnets/"
  vpc_id = module.vpc.vpc_id
}


# external IPs
resource "aws_eip" "nlb1" {
  vpc = true
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "nlb2" {
  vpc = true
  lifecycle {
    create_before_destroy = true
  }
}


locals {
  lb_public_ip_ids = [aws_eip.nlb1.id, aws_eip.nlb2.id]
}

# NLB
resource "aws_lb" "nlb" {
  name = "nlb"

  internal           = false
  load_balancer_type = "network"

  dynamic "subnet_mapping" {
    iterator = subnet
    for_each = zipmap(module.subnets.public_subnet_ids, local.lb_public_ip_ids)
    content {
      subnet_id = subnet.key
      allocation_id = subnet.value
    }
  }
}
