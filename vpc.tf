resource "aws_vpc" "Crystal_vpc" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "Crystal_vpc"
  }
}

