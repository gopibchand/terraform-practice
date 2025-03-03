resource "aws_instance" "test_instance" {
    ami = var.ami
    instance_type = var.type
    subnet_id = var.subnet
    key_name = var.key
    associate_public_ip_address = false
    availability_zone = "ap-south-1b"
    count = 1
    tags = var.tags
}

resource "aws_s3_bucket" "test_bucket" {
    bucket = "my-test-tygde"
    tags = {
        Name = "testing buc"
    }
}

resource "aws_s3_bucket" "test_bucket1" {
    bucket = "my-test-tygde1"
    tags = {
        Name = "testing buc"
    }
}