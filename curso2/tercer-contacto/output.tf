# output "instance_public_ip" {
#   value       = aws_instance.web.public_ip
#   description = "Ip publica de mi instancia"
# }

output "instance_public_ip" {
  value       = aws_eip.web_ip.public_ip
  description = "Elastic IP de la instancia"
}

output "security-group_id" {
  value       = aws_security_group.allow_shh_anywhere.id
  description = "Id del security group"
}
output "security-group_http_id" {
  value       = aws_security_group.allow_http_anywhere.id
  description = "Id del security group HTTP"
}
output "security-group_name" {
  value       = aws_security_group.allow_shh_anywhere.name
  description = "Nombre del security group"
}

output "security-group_name_description" {
  value       = aws_security_group.allow_shh_anywhere.description
  description = "Descripcion del security group"
}
