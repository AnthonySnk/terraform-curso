resource "aws_instance" "VPN" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.public_1.id
  user_data     = file("${path.module}/user_data.txt")
  security_groups = [
    aws_security_group.allow_SSH.id,
    aws_security_group.allow_VPN.id
  ]
  tags = {
    Name = "VPN - ${var.project_name}"
  }
}

resource "aws_instance" "EC2_1" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = aws_subnet.private_1.id
  security_groups = [aws_security_group.allow_SSH.id]
  tags = {
    Name = "EC2_1 - ${var.project_name}"
  }
}

resource "aws_instance" "EC2_2" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = aws_subnet.private_2.id
  security_groups = [aws_security_group.allow_SSH.id]
  tags = {
    Name = "EC2_2 - ${var.project_name}"
  }
}

resource "aws_instance" "EC2_3" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  subnet_id       = aws_subnet.private_3.id
  security_groups = [aws_security_group.allow_SSH.id]
  tags = {
    Name = "EC2_3 - ${var.project_name}"
  }
}

