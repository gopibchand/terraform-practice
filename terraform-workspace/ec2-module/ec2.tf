provider "aws" {
    region = "ap-south-1"
}

variable "ami" {
    description = "variable for instance"
}

variable "itype" {
    description = "variable for instance type"
  
}
resource "aws_instance" "awsserver" {
    ami = var.ami
    instance_type = var.itype
}