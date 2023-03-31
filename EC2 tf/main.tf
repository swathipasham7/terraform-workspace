resource "aws_vpc" "swathi" {
  cidr_block = "198.162.0.0/16"

  tags = {
    Name = "swathi"
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.swathi.id
  cidr_block = "198.162.0.0/24"

  tags = {
    Name = "mysubnet"
  }
}

resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.swathi.id

  tags = {
    Name = "mygateway"
  }
}

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.swathi.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygateway.id
  }
  tags = {
    Name = "myroute"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myroute.id
}

resource "aws_security_group" "mysecuritygroup" {
  name   = "mysecuritygroup"
  vpc_id = aws_vpc.swathi.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysecuritygroup"
  }
}