terraform {
  backend "s3" {
    bucket = "momin-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}