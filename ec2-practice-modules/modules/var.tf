variable "ami" {
    description = "ami id to be used"
    type = string
    default =  "ami-00bb6a80f01f03502"
}

variable "type" {
    description = "instance type to be create"
    type = string
    default = "t2.micro"
}

variable "key" {
    description = "key to login servers"
    type = string
    default = "aws_login"
  
}

variable "subnet" {
    description = "subnet for servers"
    type = string
    default = "subnet-0fb719b599fae05b2" 
}

variable "avizone" {
    description = "subnet for servers"
    type = string
    default = "ap-south-1b" 
}

variable "tags" {
    description = "tags for servers"
    type = map(string)
    default = {
      "Name" = "Testtf"
      "env" = "dev"
    }
}