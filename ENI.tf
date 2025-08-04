resource "aws_network_interface" "FW-LAN" {
  description = "FW-LAN10"
  subnet_id = module.network.Firewall_private_Subnet
  security_groups = [aws_security_group.CR-FW-LAN.id]

   source_dest_check = false
  tags = {
    Name = "FW-LAN"
  }
}

resource "aws_network_interface" "FW-WAN" {
  description = "FW-WAN1.10"
  subnet_id = module.network.Firewall_Subnet_public
  security_groups = [aws_security_group.CR-FW-WAN-SG.id]

  tags = {
    Name = "FW-WAN"
  }
}




