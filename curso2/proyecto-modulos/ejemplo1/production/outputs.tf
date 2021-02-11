output "connection_string" {
  value = "ssh -i ${module.ec2.key_name} ubuntu@${module.ec2.eip}"
  #module.<nombreModulo>.<nombreOutput-modulo>
}