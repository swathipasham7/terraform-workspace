resource "aws_vpc" "swathi" {
  cidr_block = "198.162.0.0/16"

  tags = {
    Name = "swathi"
  }
}

resource "aws_subnet" "swathi" {
  vpc_id            = aws_vpc.swathi.id
  count             = "3"
  cidr_block        = var.subnet_cidr_block[count.index]
  availability_zone = "${var.region}${var.availability_zone[count.index]}"
  tags = {
    Name = var.subnet_name[count.index]
  }
}


 