resource "aws_vpc" default {
  cidr_block = "10.10.0.0/16"
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  depends_on = [aws_vpc.default]
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id

  depends_on = [aws_internet_gateway.default]
}

output "vpc_id" {
  value       = aws_vpc.default.id
}
