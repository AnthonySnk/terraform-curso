resource "aws_autoscaling_group" "web" {
  name                 = "${var.project_name}-web"
  max_size             = 2
  min_size             = 0
  desired_capacity     = 0
  launch_configuration = aws_launch_configuration.web-launch-conf.name
  vpc_zone_identifier  = ["subnet-38a73b19", "subnet-b00843be", "subnet-007dd831"]

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web-asg"
    propagate_at_launch = true
  }
}
