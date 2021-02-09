resource "aws_security_group" "allow_shh_anywhere" {
  # name        = "allow_ssh_anywhere"
  name = "${var.project_name}-allow_ssh_anywhere"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id # Sino se incluye se crea una nueva

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # anywhere
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "allow_http_anywhere" {
  # name        = "allow_ssh_anywhere"
  name = "${var.project_name}-allow_http_anywhere"
  description = "Allow http inbound traffic"
  vpc_id      = var.vpc_id # Sino se incluye se crea una nueva

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # anywhere
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

