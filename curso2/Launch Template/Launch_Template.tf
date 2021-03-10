resource "aws_launch_template" "JenkinsAgentTemplate2" {
  name = "JenkinsAgentTemplate2"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 30
      volume_type           = "gp2"
      delete_on_termination = "true"
    }
  }
  #please, create your role for attach instance.
  #  iam_instance_profile {
  #    name = "Jenkins_agents_spot"
  #  }
  image_id                             = "ami-0915bcb5fa77e4892"
  instance_type                        = "t2.micro"
  instance_initiated_shutdown_behavior = "terminate"
  key_name                             = "demoiac"
  instance_market_options {
    market_type = "spot"
  }
  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.subnet_1
    security_groups             = ["${aws_security_group.sg_jenkins.id}"]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Agents-Jenkins"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      Name = "Agents-Jenkins"
    }
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Agents-Jenkins"
    }
  }
  user_data = filebase64("${path.module}/script.sh")
}
variable "subnet_1" {
  description = "public Subnet 1a"
  default     = "subnet-896590d2"
}
variable "subnet_2" {
  description = "public Subnet 1b"
  default     = "subnet-57c25d32"
}
resource "aws_security_group" "sg_jenkins" {
  name        = "sg_jenkins"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-956a4df2"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3269
    to_port     = 3269
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/22"]
  }
  ingress {
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/22"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["10.0.0.0/22"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-jenkins"
  }
}
resource "aws_autoscaling_group" "EC2-Fleet-plugin-ASG" {
  #availability_zones = ["us-east-1a", "us-east-1b"]
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
  launch_template {
    id      = aws_launch_template.JenkinsAgentTemplate2.id
    version = "$Latest"
  }
}
