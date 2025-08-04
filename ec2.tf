resource "aws_instance" "SANDBOX-DB" {
  ami =  "ami-0d64bb532e0502c46"  
  instance_type = "t2.medium" 
  associate_public_ip_address = false

  key_name = aws_key_pair.Crystal-KP-1.id

  vpc_security_group_ids = [aws_security_group.CR-FW-LAN.id,aws_security_group.SAND-QA-DB-SG.id]

  subnet_id = module.network.SAP_Private_Subnet_QAS
  
  tags = {

    Name = "SANDBOX-DB"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 30
    iops = 3000
    throughput = 125

    tags = {
      Name = "SAND/QAS-DB-Root-2"
    }
  }
}

resource "aws_ebs_volume" "SAND-QAS-DB-2" {
  availability_zone = "eu-west-1a"
  size = 30 #1370
  iops = 3000
  throughput = 125
  type = "gp3"

  tags = {
    Name = "SAND/QAS-DB-2"
  } 
}


resource "aws_volume_attachment" "SAND-QAS-DB-2-att" {
  device_name = "/dev/sdf"
  volume_id = aws_ebs_volume.SAND-QAS-DB-2.id
  instance_id = aws_instance.SANDBOX-DB.id
}


###############################################################################################

resource "aws_instance" "Management" {
 ami =  "ami-0d64bb532e0502c46"  
  instance_type = "t2.medium"
  associate_public_ip_address = false

  key_name = aws_key_pair.Crystal-KP-1.key_name

  vpc_security_group_ids = [aws_security_group.Management-SG.id, aws_security_group.vm-to-internet.id,aws_security_group.CR-FW-LAN.id]

  subnet_id = module.network.SAP_Public_2
  
  tags = {

    Name = "Management"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 30 #100
    iops = 3000
    throughput = 125

    tags = {
      Name = "Management"
    }
  }
}


resource "aws_ebs_volume" "Management-1" {
  availability_zone = "eu-west-1a"
  size = 30 #400
  iops = 3000
  throughput = 125
  type = "gp3"

  tags = {
    Name = "Management-1"
  } 
}


resource "aws_volume_attachment" "Management-1-att" {
  device_name = "xvdb"
  volume_id = aws_ebs_volume.Management-1.id
  instance_id = aws_instance.Management.id
}


####################################################################################
resource "aws_instance" "CRSAPSOL" {
  ami =  "ami-0d64bb532e0502c46"  
  instance_type = "t2.medium"
  associate_public_ip_address = false

  key_name = aws_key_pair.Crystal-KP-1.key_name

  vpc_security_group_ids = [aws_security_group.CR-FW-LAN.id,aws_security_group.CRSAPSOL-SG.id]

  subnet_id = module.network.SAP_Private_Subnet_SOLMGR
  
  tags = {

    Name = "CRSAPSOL"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 30
    iops = 3000
    throughput = 125

    tags = {
      Name = "CRSAPSOL-1"
    }
  }
}


resource "aws_ebs_volume" "CRSAPSOL-2" {
  availability_zone = "eu-west-1a"
  size = 30 #720
  iops = 3000
  throughput = 125
  type = "gp3"

  tags = {
    Name = "CRSAPSOL-2"
  } 
}


resource "aws_volume_attachment" "CRSAPSOL-2-att" {
  device_name = "/dev/sdg"
  volume_id = aws_ebs_volume.CRSAPSOL-2.id
  instance_id = aws_instance.CRSAPSOL.id
}


#############################################################################

resource "aws_instance" "CR-FW-01" {
  ami =  "ami-0d64bb532e0502c46"  
  instance_type = "t2.medium"
  key_name = aws_key_pair.Crystal-KP-1.id
  
  tags = {

    Name = "CR-FW-01"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
    tags = {
      Name = "FW2"
    }
  }


  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 30
    volume_type = "gp2"

    tags = {
      Name = "FW1"
    }
    
  }

  network_interface {
    network_interface_id = aws_network_interface.FW-WAN.id
    device_index = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.FW-LAN.id
    device_index = 1
  }

}










