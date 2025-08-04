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


# variable "aws-instance" {
#   type = string

# }

variable "destination_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0", "172.16.16.0/21"]  # local to FW CIDR blocks
}

variable "region" {
  type = string
}





variable "Bucket_name" {
  description = "S3 Bucket Name"
  type = string
}


variable "block_public_acls" {
  description = "Block public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block public policies for the bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore public ACLs for the bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict public buckets"
  type        = bool
  default     = true
}


variable "CR-SUB-11" {}
variable "sap-dev-2" {}
variable "sap-prv-dev" {}
variable "sap-prv-prddb" {}
variable "sap-prv-prdapp" {}