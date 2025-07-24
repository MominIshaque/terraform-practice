resource "aws_instance" "name" {
    ami = "ami-0150ccaf51ab55a51"
    instance_type = "t3.micro"
    tags = {
      Name = "manual"
    }

  
}
# terraform import [options] <resource_address> <resource_id>
# terraform import aws_instance.example i-0123456789abcdef0