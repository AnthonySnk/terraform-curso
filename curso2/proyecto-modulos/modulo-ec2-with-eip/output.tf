output "sg_id" {
  value = aws_security_group.sg.id
}
output "eip" {
  value = aws_eip.eip.public_ip
}
output "key_name" {
  value = var.key_name
}