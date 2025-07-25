resource "aws_instance" "name" {
    ami = "ami-08a6efd148b1f7504"
    instance_type = "t2.micro"
    #key_name = "ohio-key"
    tags = {
        Name = "THROUGH TERRAFORM USING JENKINS"
    }
  
}