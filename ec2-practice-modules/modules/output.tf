output "privateip" {
    value = [for instance in aws_instance.test_instance: instance.private_ip]
}