variable "instances" {
  type = map(any)
}

instances = {
  jenkins = {
    name                        = "jenkins",
    ami                         = "ami-0533f2ba8a1995cf9",
    instance_type               = "t3.medium"
    key_name                    = "demoiac",
    #secutiry_group_name         = onbase_sg_deep_security_manager,
    associate_public_ip_address = true,
    volume_size                 = "40"
    volume_type                 = "gp2"
    #golden_ami                  = false
    #second_volume_size          = "200"
    #user_data_base64            =  filebase64("${path.module}/script.sh")
    name_record                 = "jenkins"
  },
  artifactory = {
    name                        = "artifactory",
    ami                         = "ami-0ed149f4b21271416",
    instance_type               = "t3.medium"
    key_name                    = "demoiac",
    #secutiry_group_name         = "gd_sg_bastion",
    associate_public_ip_address = true,
    volume_size                 = "40"
    volume_type                 = "gp2"
    #golden_ami                  = false
    #user_data_base64            =  filebase64("${path.module}/script.sh")
    name_record                 = "artifactory"
  }