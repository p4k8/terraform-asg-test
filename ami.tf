
data "aws_ami" "test-ami" {
 most_recent      = true
 owners           = [var.ami-owner]
 
 filter {
   name   = "name"
   values = [var.ami-name-filter]
 }
 filter {
   name   = "root-device-type"
   values = ["ebs"]
 }
 filter {
   name   = "virtualization-type"
   values = ["hvm"]
 }
}
