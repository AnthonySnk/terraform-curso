resource "aws_launch_configuration" "web-launch-conf" {
  name_prefix   = "web_config-${var.project_name}"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [
    aws_security_group.allow_shh_anywhere.id,
    aws_security_group.allow_http_anywhere.id
  ]
  user_data = file("user-data.txt")
}
