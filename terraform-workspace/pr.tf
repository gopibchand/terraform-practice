provider "aws" {
    region = "ap-south-1"  
}

variable "ami" {
    description = "variable for ami"
}

variable "itype" {
    description = "variable for instance type"
    type = map(string)
    default = {
      "dev" = "t2.micro"
      "prod" = "t2.medium"
    }
}

module "ec2module" {
    source = "./ec2-module"
    ami=var.ami
    itype = lookup(var.itype, terraform.workspace, "t2.micro")
}