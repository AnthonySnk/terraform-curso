resource "aws_eip" "eip_vpn" {
  instance = aws_instance.VPN.id
  tags = {
    "Name" = "${var.project_name}-VPN-EIP"
  }
}
resource "aws_eip" "nat" {
  tags = {
    "Name" = "${var.project_name}-NAT-EIP"
  }
}