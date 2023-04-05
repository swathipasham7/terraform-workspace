resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
  count      = 2
  cidr_block = var.subnets_info.cidr_ranges[count.index]
  depends_on = [
    aws_vpc.myvpc
  ]

  tags = {
    Name = var.subnets_info.Names[count.index]
  }
}

resource "aws_security_group" "mysecurity" {
  name   = "mysecurity"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [
    aws_vpc.myvpc
  ]

  tags = {
    Name = "mysecurity"
  }
}

resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "mygateway"
  }

}

resource "aws_route_table" "myroute" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygateway.id
  }
  tags = {
    "Name" = "myroute"
  }
}

resource "aws_route_table_association" "routetable" {
  subnet_id      = aws_subnet.mysubnet[0].id
  route_table_id = aws_route_table.myroute.id
}

resource "aws_instance" "instances" {
  ami                         = "ami-007855ac798b5175e"
  instance_type               = "t2.micro"
  count                       = length(var.ec2_instance.Names)
  associate_public_ip_address = true
  key_name                    = "id_rsa"
  subnet_id                   = aws_subnet.mysubnet[0].id
  vpc_security_group_ids      = [aws_security_group.mysecurity.id]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file ("~/.ssh/id_rsa")
      host = self.public_ip
    }
    inline = [
      "sudo apt update",
      "sudo apt install apache2 -y"
    ]
  }
  
  tags = {
    Name = var.ec2_instance.Names[count.index]
  }
}

# resource "aws_lb_target_group" "targetgroup" {
#   name     = "targetgroup"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.myvpc.id
# }

# resource "aws_lb_target_group_attachment" "targetinstance" {
#   target_group_arn = aws_lb_target_group.targetgroup.arn
#   target_id        = aws_lb_target_group.targetgroup.id
#   port             = 80
# }

