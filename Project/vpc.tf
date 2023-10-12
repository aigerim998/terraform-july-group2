provider aws {
    region = var.region
}

resource "aws_vpc" "group_NUMBER" {
  cidr_block       = var.vpc_cidr
 
  tags = {
    Name = "group_number"
  }
}

resource "aws_subnet" "group_number1" {
  vpc_id     = aws_vpc.group_NUMBER.id
  cidr_block = var.subnet_cidr1
  availability_zone = var.az1
   map_public_ip_on_launch = var.ip_on_launch
  tags = {
    Name = "group_number1"
  }
}

resource "aws_subnet" "group_number2" {
  vpc_id     = aws_vpc.group_NUMBER.id
  cidr_block = var.subnet_cidr2
 availability_zone = var.az2
 map_public_ip_on_launch = var.ip_on_launch
  tags = {
    Name = "group_number2"
  }
}

resource "aws_subnet" "group_number3" {
  vpc_id     = aws_vpc.group_NUMBER.id
  cidr_block = var.subnet_cidr3
availability_zone = var.az3
map_public_ip_on_launch = var.ip_on_launch
  tags = {
    Name = "group_number3"
  }
}

resource "aws_internet_gateway" "GW" {
  vpc_id = aws_vpc.group_NUMBER.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.group_NUMBER.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GW.id
  }

  tags = {
    Name = "route_table"
  }
}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.group_number1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.group_number2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.group_number3.id
  route_table_id = aws_route_table.RT.id
}