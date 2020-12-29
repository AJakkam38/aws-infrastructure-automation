# Create a ec2 instance
resource "aws_instance" "dummy" {
    ami = lookup(var.AMI, var.AWS_REGION)
    instance_type = "t2.micro"
    provisioner "local-exec" {
        command = "echo ${aws_instance.dummy.private_ip}"
    }
}

output "ip_address" {
  value = aws_instance.dummy.public_ip
}