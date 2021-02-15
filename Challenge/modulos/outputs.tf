output "Main_vpc" {
  value = var.main_vpc
}
output "subnet_public_1" {
  value = var.public_1
}
output "subnet_public_2" {
  value = var.public_2
}
output "subnet_public_3" {
  value = var.public_3
}
output "subnet_private_1" {
  value = var.private_1
}
output "subnet_private_2" {
  value = var.private_2
}
output "subnet_private_3" {
  value = var.private_3
}
output "ami-used" {
  value = var.ami
}
output "enviroment" {
  value = var.environment
}
output "project_name" {
  value = var.project_name
}
output "key_name" {
  value = var.key_name
}
output "EIP-VPN" {
  value = aws_eip.eip_vpn.public_ip
}
output "private_ec2_1" {
  value = aws_instance.EC2_1.private_ip
}
output "private_ec2_2" {
  value = aws_instance.EC2_2.private_ip
}
output "private_ec2_3" {
  value = aws_instance.EC2_3.private_ip
}