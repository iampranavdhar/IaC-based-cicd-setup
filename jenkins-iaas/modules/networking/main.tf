resource "aws_vpc" "jenkins_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    Name = "jenkins-igw"
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.jenkins_vpc.id
  cidr_block = var.public_subnets[count.index].cidr
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnets[count.index].name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.jenkins_igw.id
}

resource "aws_route_table_association" "public_route_table_associations" {
  count = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.jenkins_vpc.id
  cidr_block = var.private_subnets[count.index].cidr
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = var.private_subnets[count.index].name
  }
}

# Create Elastic IPs for NAT gateways
resource "aws_eip" "nat_eip" {
  count = length(var.private_subnets)
}

# Create NAT gateways and associate them with private subnets
resource "aws_nat_gateway" "nat_gateways" {
  count = length(var.private_subnets)
  
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.private_subnets[count.index].id
}

# Create route tables and associate them with private subnets
resource "aws_route_table" "private_route_tables" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    Name = var.private_subnets[count.index].name
  }
}

resource "aws_route_table_association" "private_route_table_associations" {
  count = length(var.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_tables[count.index].id
}

# Create default route to the NAT gateway in each private route table
resource "aws_route" "private_nat_routes" {
  count          = length(var.private_subnets)
  route_table_id = aws_route_table.private_route_tables[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id
}
