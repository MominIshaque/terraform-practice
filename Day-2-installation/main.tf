resource "aws_instance" "name" {
    ami = "ami-0c803b171269e2d72"
    instance_type = "t2.micro"
    key_name = "ohio-key"
  
}