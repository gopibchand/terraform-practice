resource "aws_instance" "test_instance" {
    ami = var.ami
    instance_type = var.type
    subnet_id = var.subnet
    key_name = var.key
    associate_public_ip_address = false
    availability_zone = "ap-south-1b"
    count = 2
    tags = var.tags
}
