output "frontend_lt_id" {
  value = aws_launch_template.frontend.id
}
output "frontend_lt_version" {
  value = aws_launch_template.frontend.latest_version
  
}
output "backend_lt_id" {
  value = aws_launch_template.backend.id
  
}
output "backend_lt_version" {
  value = aws_launch_template.backend.latest_version

}
output "frontend_launch_template_name" {
  value = aws_launch_template.frontend.name
  
}
output "backend_launch_template_name" {
  value = aws_launch_template.backend.name

}
output "frontend_ami_name" {
  value = data.aws_ami.frontend_ami.name
}
output "backend_ami_name" {
  value = data.aws_ami.backend_ami.name
}