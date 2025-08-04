module "network" {
  source = "./network"
  vpc-cidr = var.vpc-cidr
  SAP_Private_Subnet_QAS_cidr = var.SAP_Private_Subnet_QAS_cidr
  SAP_Public_2_cidr = var.SAP_Public_2_cidr
  SAP_Private_Subnet_SOLMGR_cidr = var.SAP_Private_Subnet_SOLMGR_cidr
  Firewall_Subnet_public_cidr = var.Firewall_Subnet_public_cidr
  Firewall_private_Subnet = var.Firewall_private_Subnet
  destination_cidrs = var.destination_cidrs
  CR-SUB-11 =  var.CR-SUB-11
  sap-dev-2 = var.sap-dev-2
  sap-prv-dev = var.sap-prv-dev
  sap-prv-prdapp = var.sap-prv-prdapp
  sap-prv-prddb = var.sap-prv-prddb
}



module "S3" {
  source = "./s3"
  Bucket_name = var.Bucket_name
  block_public_acls = var.block_public_acls
  block_public_policy = var.block_public_policy
  ignore_public_acls = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}