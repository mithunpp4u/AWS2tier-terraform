# creating NAT gateway

# Elastic IP creation

resource "aws_eip" "myNAT-IP1" {
  domain   = "vpc"
}

#NAT A
resource "aws_nat_gateway" "myNAT1" {
  allocation_id = aws_eip.myNAT-IP1.id
  subnet_id     = var.pb_sub1_id

  tags = {
    Name = "${var.project_name}-nat-a"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.internet_gw_id]
}

#NAT B

resource "aws_eip" "myNAT-IP2" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "myNAT2" {
  allocation_id = aws_eip.myNAT-IP2.id
  subnet_id     = var.pb_sub2_id

  tags = {
    Name = "${var.project_name}-nat-b"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.internet_gw_id]
}

#creating RT & RTA for private subnets

#Prv1

resource "aws_route_table" "prvRT1" {
  vpc_id = var.vpc_id
  
  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.myNAT1.allocation_id
  }

  tags   = {
    Name = "${var.project_name}-prv-rt1"
  }
}

resource "aws_route_table_association" "prvRTA1" {
    subnet_id = var.pr_sub1_id
    route_table_id = aws_route_table.prvRT1.id
  
}

resource "aws_route_table_association" "prvRTA2" {
    subnet_id = var.pr_sub2_id
    route_table_id = aws_route_table.prvRT1.id
  
}



resource "aws_route_table" "prvRT2" {
  vpc_id = var.vpc_id
  
  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.myNAT2.allocation_id
  }

    tags   = {
    Name = "${var.project_name}-prv-rt2"
  }
}



resource "aws_route_table_association" "prvRTA3" {
    subnet_id = var.pr_sub3_id
    route_table_id = aws_route_table.prvRT2.id
  
}

resource "aws_route_table_association" "prvRTA4" {
    subnet_id = var.pr_sub4_id
    route_table_id = aws_route_table.prvRT2.id
  
}

