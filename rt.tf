resource "aws_route_table" "fgtvmpublicrt" {
  vpc_id = aws_vpc.Crystal_vpc.id

  tags = {
    Name = "FW-Public"
  }
}

resource "aws_route_table" "fgtvmprivatert" {
  vpc_id = aws_vpc.Crystal_vpc.id

  tags = {
    Name = "local to FW"
  }
}


resource "aws_route" "externalroute" {
  route_table_id         = aws_route_table.fgtvmpublicrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.InternetGateway.id
}

# resource "aws_route" "internalroute" {
#    count = length(var.destination_cidrs)
#   depends_on             = [var.aws-instance]
#   route_table_id         = aws_route_table.fgtvmprivatert.id
#   destination_cidr_block = var.destination_cidrs[count.index]
#   network_interface_id   = aws_network_interface.FW-LAN.id
# }


resource "aws_route_table_association" "public1associate" {
  subnet_id      = aws_subnet.Firewall_Subnet_public.id
  route_table_id = aws_route_table.fgtvmpublicrt.id
}


resource "aws_route_table_association" "Firewall-Private-Subnet" {
  subnet_id      = aws_subnet.Firewall_private_Subnet.id
  route_table_id = aws_route_table.fgtvmprivatert.id
}

resource "aws_route_table_association" "SAP_Private_Subnet_QAS" {
    subnet_id = aws_subnet.SAP_Private_Subnet_QAS.id
    route_table_id = aws_route_table.fgtvmprivatert.id
  
}

resource "aws_route_table_association" "sap-public-2" {
  subnet_id = aws_subnet.SAP_Public_2.id
  route_table_id = aws_route_table.fgtvmprivatert.id
}


resource "aws_route_table_association" "SAP-Private-Subnet-SOLMGR" {
  subnet_id = aws_subnet.SAP_Private_Subnet_SOLMGR.id
  route_table_id = aws_route_table.fgtvmprivatert.id
}

resource "aws_route_table_association" "CR-SUB-11-asso" {
  subnet_id = aws_subnet.CR-SUB-11.id
  route_table_id = aws_route_table.fgtvmprivatert.id
}

resource "aws_route_table_association" "SAP-DEVELOPMENT-2" {
  subnet_id = aws_subnet.sap-dev-2.id
  route_table_id = aws_route_table.fgtvmprivatert.id
}

resource "aws_route_table_association" "SAP-Private-Subnet-DEV" {
  subnet_id = aws_subnet.sap-prv-dev.id
  route_table_id = aws_route_table.fgtvmprivatert.id
}

resource "aws_route_table_association" "sap-prv-prdapp" {
  subnet_id = aws_subnet.sap-prv-prdapp.id
  route_table_id = aws_route_table.Private-Route.id
}

resource "aws_route_table_association" "sap-prv-prddp" {
  subnet_id = aws_subnet.sap-prv-prddb.id
  route_table_id = aws_route_table.Private-Route.id
}

resource "aws_route_table" "Private-Route" {
  vpc_id = aws_vpc.Crystal_vpc.id
  tags = {Name = "Private-Route"}

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.InternetGateway.id
  }
}

resource "aws_vpc_endpoint" "Crystal-S3-Endpoint" {
  vpc_id = aws_vpc.Crystal_vpc.id
  service_name = "com.amazonaws.eu-west-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.Private-Route.id
  ]

  tags = {
    Name = "S3-ENDPOINT"
  }
}

