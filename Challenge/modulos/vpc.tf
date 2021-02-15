
resource "aws_vpc" "selected" {
  cidr_block           = var.main_vpc
  enable_dns_support   = true #gives you an internal domain name
  enable_dns_hostnames = true #gives you an internal host name
  enable_classiclink   = false

  tags = {
    Name = "my-vpc - ${var.project_name}"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.selected.id
  cidr_block = element(var.private_1, 0)
  tags = {
    Name = "private_1 - ${var.project_name}"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id     = aws_vpc.selected.id
  cidr_block = element(var.private_2, 0)
  tags = {
    Name = "private_2 - ${var.project_name}"
  }
}
resource "aws_subnet" "private_3" {
  vpc_id     = aws_vpc.selected.id
  cidr_block = element(var.private_3, 0)
  tags = {
    Name = "private_3 - ${var.project_name}"
  }
}
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.selected.id
  map_public_ip_on_launch = true
  cidr_block              = element(var.public_1, 0)
  tags = {
    Name = "public_1 - ${var.project_name}"
  }
}
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.selected.id
  map_public_ip_on_launch = true
  cidr_block              = element(var.public_2, 0)
  tags = {
    Name = "public_2 - ${var.project_name}"
  }
}
resource "aws_subnet" "public_3" {
  vpc_id                  = aws_vpc.selected.id
  map_public_ip_on_launch = true
  cidr_block              = element(var.public_3, 0)
  tags = {
    Name = "public_3 - ${var.project_name}"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.selected.id
  tags = {
    Name = "gw - ${var.project_name}"
  }
}
resource "aws_route_table" "routeTable" {
  vpc_id = aws_vpc.selected.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route-table - ${var.project_name}"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.routeTable.id
}