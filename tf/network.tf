resource "aws_vpc" "vpc_main" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = "default"
  enable_dns_support               = "true"

  tags = {
    Name    = "${var.project_name}_vpc"
    Project = var.project_name
    Owner   = var.project_owner
  }

  lifecycle { create_before_destroy = true }
}


resource "aws_internet_gateway" "ig_main" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name    = "${var.project_name}_ig"
    Project = var.project_name
    Owner   = var.project_owner
  }
}

resource "aws_subnet" "public" {
  vpc_id                          = aws_vpc.vpc_main.id
  cidr_block                      = element(split(",", var.public_subnets), count.index)
  availability_zone               = element(split(",", var.azs), count.index)
  count                           = length(split(",", var.public_subnets))

  tags = {
    Name    = "${var.project_name}_public"
    Project = var.project_name
    Owner   = var.project_owner
  }

  lifecycle { create_before_destroy = true }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_main.id
  }

  tags = {
    Name    = "${var.project_name}_public_route_table"
    Project = var.project_name
    Owner   = var.project_owner
  }
}

resource "aws_route_table_association" "public" {
  count          = length(split(",", var.public_subnets))
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
  vpc_id                          = aws_vpc.vpc_main.id
  cidr_block                      = element(split(",", var.private_subnets), count.index)
  availability_zone               = element(split(",", var.azs), count.index)
  count                           = length(split(",", var.private_subnets))

  tags = {
    Name    = "${var.project_name}_private"
    Project = var.project_name
    Owner   = var.project_owner
  }

  lifecycle { create_before_destroy = true }

  map_public_ip_on_launch = false
}
