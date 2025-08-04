resource "aws_internet_gateway" "InternetGateway" {
  vpc_id = aws_vpc.Crystal_vpc.id

  tags = {
    Name = "CR-InternetGateway"
  }
}


