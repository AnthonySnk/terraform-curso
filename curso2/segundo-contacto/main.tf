resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  #Atachando un sg creado por Terraform en el proceso
  vpc_security_group_ids = [
    aws_security_group.allow_shh_anywhere.id,
    aws_security_group.allow_http_anywhere.id
  ]
  key_name = var.key_name
  # key_name = "${aws_key_pair.key-pair-terraform.name}" # para poder usar una key-pair creada por Terraform
  user_data = file("user-data.txt")
  tags = {
    "Name" = "${var.project_name}-Instance-curso-2"
  }
}
