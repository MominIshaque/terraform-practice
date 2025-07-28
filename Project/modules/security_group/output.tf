output "bastion_sg" {
    value = aws_security_group.bastion-host.id
}
output "alb_backend_sg" {
    value = aws_security_group.alb-backend-sg.id
}
output "alb_frontend_sg" {
    value = aws_security_group.alb-frontend-sg.id
}
output "rds_sg" {
    value = aws_security_group.book-rds-sg.id
  
}