output "main_vpc" {
  value = module.challenge.Main_vpc
  #module.<nombreModulo>.<nombreOutput-modulo>
}
output "project_name" {
  value = module.challenge.project_name
}
output "environment" {
  value = module.challenge.enviroment
}
output "AMI" {
  value = module.challenge.ami-used
}
output "key_name" {
  value = module.challenge.key_name
}
output "EIP-vpn" {
  value = module.challenge.EIP-VPN
}
