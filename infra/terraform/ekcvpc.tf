resource "aws_vpc" "vpc-for-eks" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "eks-vpc"
    }
}

resource "aws_subnet" "public_subnet_1a" {
    vpc_id = aws_vpc.vpc-for-eks.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-2a"
    map_public_ip_on_launch = true
    tags = {
      Name = "public-subnet-1a"
    }
}

resource "aws_subnet" "public_subnet_1c" {
    vpc_id = aws_vpc.vpc-for-eks.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-1c"
    }
}

resource "aws_subnet" "private_subnet_1a" {
    vpc_id = aws_vpc.vpc-for-eks.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-northeast-2a"
    tags = {
        Name = "private-subnet-1a"
    }
}

resource "aws_subnet" "private_subnet_1c" {
    vpc_id = aws_vpc.vpc-for-eks.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "ap-northeast-2c"
    tags = {
        Name = "private-subnet-1c"
    }
}

resource "aws_internet_gateway" "eksigw" {
    vpc_id = aws_vpc.vpc-for-eks.id
    tags = {
        Name = "EKS-Internet-Gateway"
    }
}

resource "aws_default_route_table" "public_rt" {
    default_route_table_id = aws_vpc.vpc-for-eks.default_route_table_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eksigw.id
    }

    tags = {
        Name = "public-route-table"
    }
}

resource "aws_route_table_association" "public_rta_a" {
    subnet_id      = aws_subnet.public_subnet_1a.id
    route_table_id = aws_default_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta_c" {
    subnet_id      = aws_subnet.public_subnet_1c.id
    route_table_id = aws_default_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc-for-eks.id

    tags = {
        Name = "private-route-table"
    }
}

resource "aws_route_table_association" "private_rta_a" {
    subnet_id      = aws_subnet.private_subnet_1a.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rta_c" {
    subnet_id      = aws_subnet.private_subnet_1c.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "eks-eip" {
  vpc = true
}

resource "aws_nat_gateway" "eks-nat" {
  allocation_id = "${aws_eip.eks-eip.id}"
  subnet_id     = "${aws_subnet.public_subnet_1a.id}"
}

resource "aws_route" "private_rt_route" {
    route_table_id              = aws_route_table.private_rt.id
    destination_cidr_block      = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-nat.id
}
