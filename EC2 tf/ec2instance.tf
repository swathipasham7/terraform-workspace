resource "aws_instance" "terraform" {
  ami                         = "ami-0fcf52bcf5db7b003"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "terraform"
  vpc_security_group_ids      = [aws_security_group.mysecuritygroup.id]
  subnet_id                   = aws_subnet.mysubnet.id

  tags = {
    Name = "terraform"
  }
}
