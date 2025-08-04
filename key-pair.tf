resource "tls_private_key" "Crystal-KP-1" {
  algorithm = "RSA"
  rsa_bits = 4096
}
resource "aws_key_pair" "Crystal-KP-1" {
  key_name = "Crystal-KP-1"
  public_key = tls_private_key.Crystal-KP-1.public_key_openssh
}
resource "local_file" "Crystal-KP-1-file" {
  content = tls_private_key.Crystal-KP-1.private_key_pem
  filename = "Crystal-KP-1.pem"
}


