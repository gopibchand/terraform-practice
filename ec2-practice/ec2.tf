provider "aws" {
    region = "ap-south-1"
}
resource "aws_instance" "test_instance" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    subnet_id = "subnet-0abb918afa6ea9505"
    key_name = "aws_login"
    associate_public_ip_address = false
    availability_zone = "ap-south-1b"
}
