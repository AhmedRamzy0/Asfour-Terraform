output "vpc-id" {
  value = aws_vpc.Crystal_vpc.id
}

output "SAP_Private_Subnet_QAS" {
  value = aws_subnet.SAP_Private_Subnet_QAS.id
}

output "SAP_Public_2" {
  value = aws_subnet.SAP_Public_2.id
}

output "SAP_Private_Subnet_SOLMGR" {
  value = aws_subnet.SAP_Private_Subnet_SOLMGR.id
}

output "Firewall_Subnet_public" {
  value = aws_subnet.Firewall_Subnet_public.id
}

output "Firewall_private_Subnet" {
  value = aws_subnet.Firewall_private_Subnet.id
}

output "fgtvmprivate-rt" {
  value = aws_route_table.fgtvmprivatert.id
}

output "CR-SUB-11" {
  value = aws_subnet.CR-SUB-11.id
}

output "sap-dev-2" {
  value = aws_subnet.sap-dev-2.id
}

output "sap-prv-dev" {
  value = aws_subnet.sap-prv-dev.id
}

output "sap-prv-prddb" {
  value = aws_subnet.sap-prv-prddb.id
}

output "sap-prv-prdapp" {
  value = aws_subnet.sap-prv-prdapp.id
}
# output "EIP-FW-Wan" {
#   value = aws_eip.FW-wan.id
# }

# output "FW-LAN" {
#   value = aws_network_interface.FW-LAN.id
# }

# output "FW-WAN" {
#   value = aws_network_interface.FW-WAN.id
# }
