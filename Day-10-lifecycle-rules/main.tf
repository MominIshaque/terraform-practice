provider "aws" {

}
resource "aws_instance" "instance1" {
  ami           = "ami-0150ccaf51ab55a51"
  instance_type = "t2.micro"
  key_name      = "issakprod"
  tags = {
    Name = "lifecycle"
  }

  lifecycle {
    create_before_destroy = true
   # prevent_destroy = true
    ignore_changes = [tags, ]
  }
  
}