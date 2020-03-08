resource "aws_sns_topic" "test-asg" {
  name = "test-asg"
}

resource "aws_autoscaling_notification" "test-notifications" {
  group_names = [
    "${aws_autoscaling_group.bastion-asg.name}",
    "${aws_autoscaling_group.target-asg.name}",
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  topic_arn = aws_sns_topic.test-asg.arn
}
