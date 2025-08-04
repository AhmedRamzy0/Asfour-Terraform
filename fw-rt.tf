resource "aws_route" "internalroute" {
   count = length(var.destination_cidrs)
  depends_on             = [aws_instance.CR-FW-01]
  route_table_id         = module.network.fgtvmprivate-rt
  destination_cidr_block = var.destination_cidrs[count.index]
  network_interface_id   = aws_network_interface.FW-LAN.id
}