resource "aws_security_group" "CR-FW-LAN" {
  name        = "CR-FW-LAN"
  description = "CR-FW-LAN"
  vpc_id      = module.network.vpc-id

  ingress {
    from_port   = 3200
    to_port     = 3200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 44301
    to_port     = 44301
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

          ######################CR-FW-WAN-SG#########################
resource "aws_security_group" "CR-FW-WAN-SG" {
  vpc_id = module.network.vpc-id
  tags = {Name = "Firewall-WAN-SG"}
  name = "CR-WAN-SG"

  ingress {
    from_port = 0 
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0 
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

##########################################################################
resource "aws_security_group" "SAND-QA-DB-SG" {
  name        = "SAND/QA-DB-SG"
  description = "SAND/QA-DB Security Group"
  vpc_id      = module.network.vpc-id

  ingress {
    description = "Asfour Access 2"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["41.33.101.114/32"]
  }

  ingress {
    description = "ECS Access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["217.139.86.10/32"]
  }

  ingress {
    description = "Asfour Access 1"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["41.196.65.18/32"]
  }

}


resource "aws_security_group_rule" "allow_management_in_sandDB" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.SAND-QA-DB-SG.id
  source_security_group_id = aws_security_group.Management-SG.id
  description              = "Allow traffic from management"
}

resource "aws_security_group_rule" "allow_crsap_in_sandDB" {
  description = "Allow All Traffic from CRSAP-SOL"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.SAND-QA-DB-SG.id
  source_security_group_id = aws_security_group.CRSAPSOL-SG.id
}



resource "aws_security_group_rule" "allow-dev-in-sandDB" {
  description = "allow Traffic Dev"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.SAND-QA-DB-SG.id
  source_security_group_id = aws_security_group.DEV-SG.id
}


resource "aws_security_group_rule" "Allow-sap-router-sg" {
  description = "Allow all traffic from SAP/Router"
  type = "ingress"
  from_port = 0 
  to_port = 0 
  protocol = "-1"
  security_group_id = aws_security_group.SAND-QA-DB-SG.id
  source_security_group_id = aws_security_group.SAP-Router-SG.id 
}

resource "aws_security_group_rule" "outbound-sand-crfw-lan" {
  type = "egress"
  from_port = 0 
  to_port = 0 
  protocol = "-1"
  security_group_id = aws_security_group.SAND-QA-DB-SG.id 
  source_security_group_id = aws_security_group.CR-FW-LAN.id
}

resource "aws_security_group_rule" "outbound-sand-toitself" {
  type = "egress"
  from_port = 0 
  to_port = 0 
  protocol = "-1"
  security_group_id = aws_security_group.SAND-QA-DB-SG.id 
  source_security_group_id = aws_security_group.SAND-QA-DB-SG.id
}

##############################################################################

resource "aws_security_group" "Management-SG" {
  name        = "Management-SG"
  description = "Management Security Group"
  vpc_id      = module.network.vpc-id

 ingress {
  description = "ECS Access"
  from_port = 44301
  to_port = 44301 
  protocol = "tcp"
  cidr_blocks = ["217.139.86.10/32"]
 }

  ingress {
  description = "Crystal Access 2"
  from_port = 44300
  to_port = 44300 
  protocol = "tcp"
  cidr_blocks = ["41.33.101.114/32"]
 }

 ingress {
  description = "Crystal Access 1"
  from_port = 44301
  to_port = 44301
  protocol = "tcp"
  cidr_blocks = ["41.196.65.18/32"]
 }

  ingress {
  description = "Crystal Access 2"
  from_port = 44301
  to_port = 44301
  protocol = "tcp"
  cidr_blocks = ["41.33.101.114/32"]
 }

 ingress {
  from_port = 0
  to_port = 0
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
  description = "TESTPUB"
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
  description = "ECS Access"
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  cidr_blocks = ["217.139.86.10/32"]
 }

 ingress {
  description = "Crystal Access 2"
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  cidr_blocks = ["41.33.101.114/32"]
 }

 ingress {
  description = "Crystal Access 1"
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  cidr_blocks = ["41.196.65.18/32"]
 }


 ingress {
  description = "Crystal Access 1"
  from_port = 44300
  to_port = 44300
  protocol = "tcp"
  cidr_blocks = ["41.196.65.18/32"]
 }

 ingress {
  description = "IT-Visionary M"
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  cidr_blocks = ["154.186.182.135/32"]

 }



ingress {
  description = "ECS Access"
  from_port = 44300
  to_port = 44300
  protocol = "tcp"
  cidr_blocks = ["217.139.86.10/32"]
 }


ingress {
  description = "HOSSAM"
  from_port = 3389
  to_port = 3389
  protocol = "tcp"
  cidr_blocks = ["41.33.164.121/32"]
 }


egress {
  from_port = 0 
  to_port = 0 
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

}

resource "aws_security_group_rule" "allow-crsapol-port30103-in-managment" {
  type = "ingress"
  from_port = 30103
  to_port = 30103
  protocol = "tcp"
  security_group_id = aws_security_group.Management-SG.id
  source_security_group_id = aws_security_group.CRSAPSOL-SG.id
  description = "Allow port 30103 from CRSAPSOL to Managment"
}

resource "aws_security_group_rule" "allow-alltraffic-from-crsapol-in-managment" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "tcp"
  security_group_id = aws_security_group.Management-SG.id
  source_security_group_id = aws_security_group.CRSAPSOL-SG.id
  description = "Allow all traffic from CRSAPSOL to Managment"
}

resource "aws_security_group_rule" "FW" {
  type = "ingress"
  from_port = 0 
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.Management-SG.id
  source_security_group_id = aws_security_group.Fortinet-FortiGate-Security-Group.id
  description = "FW"
}

resource "aws_security_group_rule" "allow-sandqas-in-management" {
  type = "ingress"
  from_port = 0 
  to_port = 0 
  protocol = "-1"
  security_group_id = aws_security_group.Management-SG.id 
  source_security_group_id = aws_security_group.SAND-QA-DB-SG.id
}

resource "aws_security_group_rule" "CR-FW-LAN-IN-Management" {
  type = "ingress"
  from_port = 0 
  to_port = 0
  protocol = "icmp"
  security_group_id = aws_security_group.Management-SG.id
  source_security_group_id = aws_security_group.CR-FW-LAN.id
}


resource "aws_security_group_rule" "vm-to-internet" {
  type = "ingress"
  from_port = 0 
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.Management-SG.id
  source_security_group_id = aws_security_group.VM-Internet.id 
}

###################################################################

resource "aws_security_group" "VM-Internet" {
  vpc_id = module.network.vpc-id
  tags = {Name = "allow internet"}
  name = "VM-Internet-SG"

  ingress {
    from_port = 0 
    to_port =  0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


   egress {
    from_port = 0 
    to_port =  0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#####################################################################################

resource "aws_security_group" "CRSAPSOL-SG" {
  name = "CRSAPSOL-SG"
  description = "CRSAPSOL-SG"
  vpc_id = module.network.vpc-id

  ingress {
    description = "ECS Access"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["217.139.86.10/32"]
  }
  ingress {
    description = "Asfour Access 2"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["41.33.101.114/32"] 
  }

  ingress {
    description = "Asfour Access 1"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["41.196.65.18/32"] 
  }

}

resource "aws_security_group_rule" "FW-CRSAPSOL" {
  type = "ingress"
  from_port = 0 
  to_port = 0
  protocol = "icmp"
  security_group_id = aws_security_group.CRSAPSOL-SG.id
  source_security_group_id = aws_security_group.Fortinet-FortiGate-Security-Group.id
  description = "FW"
}

resource "aws_security_group_rule" "allow-CR-FW-LAN-in-crsapol" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "icmp"
  security_group_id = aws_security_group.CRSAPSOL-SG.id
  source_security_group_id = aws_security_group.Fortinet-FortiGate-Security-Group.id
}

resource "aws_security_group_rule" "allow-sandDB-in-crsapol-1" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.CRSAPSOL-SG.id
  source_security_group_id = aws_security_group.Fortinet-FortiGate-Security-Group.id
  description = "Allow all Traffic from SAND/QA"
}

resource "aws_security_group_rule" "allow-sandDB-in-crsapol-2" {
  type = "ingress"
  from_port = 0
  to_port = 0 
  protocol = "-1"
  security_group_id = aws_security_group.CRSAPSOL-SG.id
  source_security_group_id = aws_security_group.Management-SG.id
  description = "Allow all Traffic from Managment"
}


resource "aws_security_group_rule" "allow-saprouter-in-CRSAP" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.CRSAPSOL-SG.id
  source_security_group_id = aws_security_group.SAP-Router-SG.id
}



##############################################################################  

resource "aws_security_group" "DEV-SG" {
  name = "DEV-SG"
  description = "DEV-SG"
  vpc_id = module.network.vpc-id

  ingress {
    from_port = 44310
    to_port = 44310
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "sap"
  }

  ingress {
    from_port = 3210
    to_port = 3210
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "sap"
  }
  ingress {
    from_port = 8010
    to_port = 8010
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "sap"
  }
  ingress {
    from_port = 3310
    to_port = 3310
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "sap"
  }
  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh"
  }
}


resource "aws_security_group_rule" "allow-traffic-from-QAS" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.DEV-SG.id
  source_security_group_id = aws_security_group.SAND-QA-DB-SG.id
}

##########################################################################

resource "aws_security_group" "Fortinet-FortiGate-Security-Group" {
  name = "Fortinet FortiGate Security Group"
  description = "Fortinet FortiGate (BYOL) Next-Generation Firewall-7.0"
  vpc_id = module.network.vpc-id
  ingress {
    from_port = 0 
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 541
    to_port = 541
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group_rule" "allow-managment-in-Fortinet" {
  description = "Allow All Traffic from Management"
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.Fortinet-FortiGate-Security-Group.id
  source_security_group_id = aws_security_group.Management-SG.id
}


resource "aws_security_group" "vm-to-internet" {
  name = "VM to internet"
  description = "all internet service for upgrade"
  vpc_id = module.network.vpc-id

  ingress {
    from_port = 0 
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
     from_port = 0 
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


############################################

# resource "aws_security_group" "CR-FW-WAN" {
#   name = "CR-FW-WAN"
#   description = "CR-FW-WAN"
#   vpc_id = module.network.vpc-id
#   ingress {
#     description = "ROUTER"
#     from_port = 3299
#     to_port = 3299
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "ROUTER"
#     from_port = 8001
#     to_port = 8001
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "QAS"
#     from_port = 8020
#     to_port = 8020
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "dev"
#     from_port = 3310
#     to_port = 3310
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "ssh"
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port = 3201
#     to_port = 3201
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "test"
#     from_port = 0
#     to_port = 0
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# ingress {
#     description = "DEV"
#     from_port = 8010
#     to_port = 8010
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "SOL"
#     from_port = 3300
#     to_port = 3300
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "QAS"
#     from_port = 3320
#     to_port = 3320
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "SOL"
#     from_port = 8000
#     to_port = 8000
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "RDP"
#     from_port = 6666
#     to_port = 6666
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "QAS"
#     from_port = 44320
#     to_port = 44320
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "DEV"
#     from_port = 44310
#     to_port = 44310
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "SAND"
#     from_port = 44301
#     to_port = 44301
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     from_port = 443
#     to_port = 443
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "SOL"
#     from_port = 44300
#     to_port = 44300
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "DEV"
#     from_port = 3210
#     to_port = 3210
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "CR-FW-WAN-SG"
#   }
# }




resource "aws_security_group" "SAP-Router-SG" {
  vpc_id = module.network.vpc-id
  name = "SAP-ROUTER_SG"
  tags = {Name = "SAP-ROUTER_SG"}
}