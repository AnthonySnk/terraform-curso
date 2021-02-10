resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.allow_shh_anywhere.id,
    aws_security_group.allow_http_anywhere.id
  ]
  key_name = var.key_name
  user_data = file("user-data.txt")
  tags = {
    "Name" = "${var.project_name}-Instance-curso-2"
  }
}
