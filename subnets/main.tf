variable "vpc_id" {
  type = string
}

locals {
  availability_zones       = ["us-east-1a", "us-east-1b"]
  public_subnet_cidr_block = "10.10.1.0/24"
  public_subnet_count      = length(local.availability_zones)
}

resource "aws_subnet" "public" {
  count             = length(local.availability_zones)
  vpc_id            = var.vpc_id
  availability_zone = local.availability_zones[count.index]

  cidr_block = cidrsubnet(
      local.public_subnet_cidr_block,
      ceil(log(local.public_subnet_count * 2, 2)),
      local.public_subnet_count + count.index)
}

output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}
