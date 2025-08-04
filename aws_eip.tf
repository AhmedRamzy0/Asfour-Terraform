resource "aws_eip" "FW-wan" {
  depends_on = [ aws_instance.CR-FW-01]
  domain = "vpc"
  network_interface = aws_network_interface.FW-WAN.id
  tags = {
    Name = "FW-wan"
  }
}


resource "aws_eip" "FW-elsitc-ip2" {
  tags = {
    Name = "FW-elsitc-ip2"
  }
}