module "prod" {
  source        = "github.com/MominIshaque/terraform-practice/Day-9-Modules"
  ami_id        = "ami-0150ccaf51ab55a51"
  instance_type = "t2.micro"
  key           = "issakprod"
  az            = "us-east-1a"
  name          = "MominIshaque"
}