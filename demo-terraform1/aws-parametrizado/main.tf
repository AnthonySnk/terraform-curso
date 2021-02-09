provider "aws" {
  shared_credentials_file = "/Users/tfsvr/.aws/credentials"
  region                  = "us-east-1"
}

resource "aws_instance" "demo-parametrizado" {
  #   colocar todos los parametros aqui 
  ami           = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
  security_groups = [ "aws_security_group.ssh_conection.name" ]
  # security_groups = [ "aws_security_group.NOMBRE_DEL_SG.name" ]
  # key_name = "mi-llave"
}
# Creando el security groups
resource "aws_security_group" "ssh_conection" {
  name = var.sg_name
  # ingress {
  #   description = "TLS from VPC"
  #   from_port   = 443
  #   to_port     = 443
  #   protocol    = "tcp"
  #   cidr_blocks = [aws_vpc.main.cidr_block]
  # }

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
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
