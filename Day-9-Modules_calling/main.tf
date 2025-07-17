module "dev" {
  source = "../Day-9-Modules"
  # Pass variables to the module
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key           = var.key
  az            = var.az
  name          = var.name
}