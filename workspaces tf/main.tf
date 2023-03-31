resource "aws_vpc" "workspace" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "workspace-${terraform.workspace}"
    Env  = "terraform.workspace"
  }
}