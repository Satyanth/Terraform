# Creating vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"

}

#public subnet Route table
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.vpc.id
}

#Route table mapping to public subnet and route table
resource "aws_route_table_association" "public_subnet_route_map" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
  depends_on = [aws_route_table.public_subnet_route_table]
}

#Private subnet route table
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = aws_vpc.vpc.id
}

#Route table mapping to private subnet and route table
resource "aws_route_table_association" "private_subnet_route_map" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_subnet_route_table.id
  depends_on = [aws_route_table.private_subnet_route_table]
}

#Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_CIDR
  map_public_ip_on_launch = true # This condition makes the subnet as public, assigns ipv4 address
}

#Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_CIDR

  # As the map_public_ip_on_launch is not provided, it is by default false which makes it private subnet
}