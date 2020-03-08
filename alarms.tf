resource "aws_cloudwatch_metric_alarm" "cpu-alarm-target" {
  alarm_name          = "cpu-alarm-target"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "90"
  dimensions = {
    AutoScalingGroupName = "target-asg"
  }
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.target-asg-pol.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-bastion" {
  alarm_name          = "cpu-alarm-bastion"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "90"
  dimensions = {
    AutoScalingGroupName = "bastion-asg"
  }
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.bastion-asg-pol.arn]
}
