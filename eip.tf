resource "aws_eip" "SAPRouter" {
  tags = {
    Name = "SAPRouter"
  }
}

