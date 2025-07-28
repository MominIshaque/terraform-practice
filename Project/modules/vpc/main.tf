#  creating vpc 

resource "aws_vpc" "three-tier" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# public subnet for frontend load balancer 

resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.three-tier.id
  cidr_block              = var.pub1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = var.pub1_name
  }
}

resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.three-tier.id
  cidr_block              = var.pub2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = var.pub2_name
  }
}

#fronend server

resource "aws_subnet" "prvt3" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = var.prvt3_cidr
  availability_zone = var.az1

  tags = {
    Name = var.prvt3_name
  }
}

resource "aws_subnet" "prvt4" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = var.prvt4_cidr
  availability_zone = var.az2

  tags = {
    Name = var.prvt4_name
  }
}

#Backend server 

resource "aws_subnet" "prvt5" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = var.prvt5_cidr
  availability_zone = var.az1

  tags = {
    Name = var.prvt5_name
  }
}

resource "aws_subnet" "prvt6" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = var.prvt6_cidr
  availability_zone = var.az2

  tags = {
    Name = var.prvt6_name
  }
}

#rds

resource "aws_subnet" "prvt7" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = var.prvt7_cidr
  availability_zone = var.az1

  tags = {
    Name = var.prvt7_name
  }
}

resource "aws_subnet" "prvt8" {
  vpc_id            = aws_vpc.three-tier.id
  cidr_block        = var.prvt8_cidr
  availability_zone = var.az2

  tags = {
    Name = var.prvt8_name
  }
}

#  creating internet gateway

resource "aws_internet_gateway" "three-tier-ig" {
  vpc_id = aws_vpc.three-tier.id

  tags = {
    Name = var.igw_name
  }
}

#  creating public route table

resource "aws_route_table" "three-tier-pub-rt" {
  vpc_id = aws_vpc.three-tier.id

  route {
    cidr_block = var.anywhere
    gateway_id = aws_internet_gateway.three-tier-ig.id
  }

  tags = {
    Name = var.public_rt_name
  }
}

#  attaching pub-1a subnet to public route table

resource "aws_route_table_association" "public-1a" {
  route_table_id = aws_route_table.three-tier-pub-rt.id
  subnet_id      = aws_subnet.pub1.id
}

#  attaching pub-2b subnet to public route table

resource "aws_route_table_association" "public-2b" {
  route_table_id = aws_route_table.three-tier-pub-rt.id
  subnet_id      = aws_subnet.pub2.id
}

#  creating elastic ip for nat gateway

resource "aws_eip" "eip" {}

#  creating nat gateway

resource "aws_nat_gateway" "cust-nat" {
  subnet_id         = aws_subnet.pub1.id
  allocation_id     = aws_eip.eip.id
  connectivity_type = "public"

  tags = {
    Name = var.nat_name
  }
}

#  creating private route table 

resource "aws_route_table" "three-tier-prvt-rt" {
  vpc_id = aws_vpc.three-tier.id

  route {
    cidr_block = var.anywhere
    gateway_id = aws_nat_gateway.cust-nat.id
  }

  tags = {
    Name = var.private_rt_name
  }
}

#  attaching prvt-3a subnet to private route table

resource "aws_route_table_association" "prvivate-3a" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt3.id
}

#  attaching prvt-4b subnet to private route table

resource "aws_route_table_association" "prvivate-4b" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt4.id
}

#  attaching prvt-5a subnet to private route table

resource "aws_route_table_association" "prvivate-5a" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt5.id
}

#  attaching prvt-6b subnet to private route table

resource "aws_route_table_association" "prvivate-6b" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt6.id
}

#  attaching prvt-7a subnet to private route table

resource "aws_route_table_association" "prvivate-7a" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt7.id
}

#  attaching prvt-8b subnet to private route table

resource "aws_route_table_association" "prvivate-8b" {
  route_table_id = aws_route_table.three-tier-prvt-rt.id
  subnet_id      = aws_subnet.prvt8.id
}
