#Creating vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
}

#public subnet Route table
resource "aws_route_table" "public_subnet_one_route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_subnet_two_route_table" {
  vpc_id = aws_vpc.vpc.id
}

#Route table mapping to public subnet and route table
resource "aws_route_table_association" "public_subnet_one_route_map" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_subnet_one_route_table.id
  depends_on     = [ aws_route_table.public_subnet_one_route_table ]
}

resource "aws_route_table_association" "public_subnet_two_route_map" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_subnet_two_route_table.id
  depends_on     = [ aws_route_table.public_subnet_two_route_table ]
}

resource "aws_route" "route_acess_to_internetgateway_one" {
  route_table_id         = aws_route_table.public_subnet_one_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route" "route_access_to_internetgateway_two" {
  route_table_id         = aws_route_table.public_subnet_two_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

#Internet gateway for access to the internet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

#Private subnet route table
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.vpc.id
}

#Route table mapping to private subnet and route table
resource "aws_route_table_association" "private_subnet_route_map" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_subnet_route_table.id
  depends_on     = [aws_route_table.private_subnet_route_table]
}

#Public subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_CIDR_1
  map_public_ip_on_launch = true # This condition makes the subnet as public, assigns ipv4 address
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_CIDR_2
  map_public_ip_on_launch = true
}

#Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_CIDR

  # As the map_public_ip_on_launch is not provided, it is by default false which makes it private subnet
}