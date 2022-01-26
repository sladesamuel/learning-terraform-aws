resource "aws_vpc" "my_vpc" {
  cidr_block = "10.150.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}
