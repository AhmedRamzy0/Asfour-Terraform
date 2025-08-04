variable "vpc-cidr" {
  type = string
}


variable "SAP_Private_Subnet_QAS_cidr" {
  type = string
}

variable "SAP_Public_2_cidr" {
  type = string
}

variable "SAP_Private_Subnet_SOLMGR_cidr" {
  type = string
}

variable "Firewall_Subnet_public_cidr" {
  type = string
}


variable "Firewall_private_Subnet" {
  type = string
}




variable "destination_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0", "172.16.16.0/21"]  # local to FW CIDR blocks
}

variable "CR-SUB-11" {}
variable "sap-dev-2" {}
variable "sap-prv-dev" {}
variable "sap-prv-prddb" {}
variable "sap-prv-prdapp" {}

