resource "aws_launch_template" "asg_lt" {
  name_prefix   = "web-asg-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.asg_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "ASG-web-alejandro"
      Owner   = var.owner
      Project = var.project
    }
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                      = "web-asg"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity           = var.asg_min_size
  vpc_zone_identifier       = aws_subnet.public[*].id
  launch_template {
    id      = aws_launch_template.asg_lt.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  health_check_grace_period = 30
  force_delete              = true
  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project
    propagate_at_launch = true
  }

  tag {
    key                 = "Owner"
    value               = "Alejandro Martinez"
    propagate_at_launch = true
  }
}
