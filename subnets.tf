resource "aws_subnet" "SAP_Private_Subnet_QAS" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.SAP_Private_Subnet_QAS_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = "SAP-Private-Subnet-QAS"
  }
}

resource "aws_subnet" "SAP_Public_2" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.SAP_Public_2_cidr
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "SAP_Public_2"
  }

}

resource "aws_subnet" "SAP_Private_Subnet_SOLMGR" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.SAP_Private_Subnet_SOLMGR_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = "SAP_Private_Subnet_SOLMGR"
  }
}


resource "aws_subnet" "Firewall_Subnet_public" {

    vpc_id = aws_vpc.Crystal_vpc.id
    cidr_block = var.Firewall_Subnet_public_cidr
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "Firewall_Subnet_public"
    }
}


resource "aws_subnet" "Firewall_private_Subnet" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.Firewall_private_Subnet
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Firewall_private_Subnet"
  }

}

resource "aws_subnet" "CR-SUB-11" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.CR-SUB-11
  availability_zone = "eu-west-1a"

  tags = {
    Name = "CR-SUB-11"
  }

}

resource "aws_subnet" "sap-dev-2" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.sap-dev-2
  availability_zone = "eu-west-1a"

  tags = {
    Name = "sap-dev-2"
  }
}

resource "aws_subnet" "sap-prv-dev" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.sap-prv-dev
  availability_zone = "eu-west-1a"

  tags = {
    Name = "sap-prv-dev"
  }
}

resource "aws_subnet" "sap-prv-prddb" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.sap-prv-prddb
  availability_zone = "eu-west-1a"

  tags = {
    Name = "sap-prv-prddb"
  }
}

resource "aws_subnet" "sap-prv-prdapp" {
  vpc_id = aws_vpc.Crystal_vpc.id
  cidr_block = var.sap-prv-prdapp
  availability_zone = "eu-west-1a"

  tags = {
    Name = "sap-prv-prdapp"
  }
}

