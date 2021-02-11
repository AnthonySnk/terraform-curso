resource "aws_autoscaling_group" "web" {
  name                 = "${var.project_name}-web"
  max_size             = 3
  min_size             = 0
  desired_capacity     = 0

  health_check_type    = "ELB"
  health_check_grace_period = 10 # despues de encendida 10s comenzara el checkeo
  
  load_balancers       = [aws_elb.web.name]
  launch_configuration = aws_launch_configuration.web-launch-conf.name
  vpc_zone_identifier  = data.aws_subnet_ids.selected.ids

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web-asg"
    propagate_at_launch = true
  }
}
