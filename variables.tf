variable "region"{
  default = "eu-central-1"
}

variable "cidr-0"{
  description = "Highest permissible CIDR"
  default = "0.0.0.0/0"
}

variable "ami-name-filter" {
   description = "AMI name filter"
   default = "packer-example-deb10*"
}
 
variable "ami-owner" {
   description = "AMI owner filter"
   default = "self"
}

variable "instance-type" {
   description = "EC2 instance type"
   default = "t2.micro"
}
 
variable "tag_name" {
   description = "Value of the Name tag for all resources"
   default = "terra-test"
}
