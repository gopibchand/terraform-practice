module "aws_ec2" {
    source = "./modules"
    subnet = "subnet-0abb918afa6ea9505"
    ami = "ami-0d682f26195e9ec0f"
}