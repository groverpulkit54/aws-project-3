
data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Type"
    values = [var.public_subnet_tags["Type"]]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Type"
    values = [var.private_subnet_tags["Type"]]
  }
}
