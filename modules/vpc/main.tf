#creating vpc

resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidrblk
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

#creating internet gateway for the above created vpc

resource "aws_internet_gateway" "my_gw1" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project_name}-gw"
  }
}

#fetching the AZs of this region
data "aws_availability_zones" "AZs" {}
  
#creating the first public subnet

resource "aws_subnet" "mypsub1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pb_sub1_cidrblk
  availability_zone = data.aws_availability_zones.AZs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub1-${var.pb_sub1_cidrblk}"
  }
}

#creating the second public subnet
resource "aws_subnet" "mypsub2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pb_sub2_cidrblk
  availability_zone = data.aws_availability_zones.AZs[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub2-${var.pb_sub2_cidrblk}"
  }
}

#creating route table for the above 2 public subnets

resource "aws_route_table" "pubRT1" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_gw1.id
    }

    tags = {
    Name = "Pub_RT-${var.project_name}"
  }
  
}

#creating RTA for above 2 pub subnets

resource "aws_route_table_association" "pubRTA1" {
    route_table_id = aws_route_table.pubRT1.id
    subnet_id = aws_subnet.mypsub1.id
}
resource "aws_route_table_association" "pubRTA2" {
    route_table_id = aws_route_table.pubRTA2.id
    subnet_id = aws_subnet.mypsub1.id
}

# creating private subnets

#prv sub 1

resource "aws_subnet" "myprv1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pr1_sub1_cidrblk
  availability_zone = data.aws_availability_zones.AZs[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "prvsub1-${var.pr1_sub1_cidrblk}"
  }
}

#prv sub 2

resource "aws_subnet" "myprv2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pr1_sub2_cidrblk
  availability_zone = data.aws_availability_zones.AZs[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "prvsub2-${var.pr1_sub2_cidrblk}"
  }
}

#prv sub 3

resource "aws_subnet" "myprv3" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pr2_sub1_cidrblk
  availability_zone = data.aws_availability_zones.AZs[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "prvsub3-${var.pr2_sub1_cidrblk}"
  }
}

#prv sub 4

resource "aws_subnet" "myprv4" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pr2_sub2_cidrblk
  availability_zone = data.aws_availability_zones.AZs[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "prvsub3-${var.pr2_sub2_cidrblk}"
  }
}





