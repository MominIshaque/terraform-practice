output "vpc_id" {
  value = aws_vpc.three-tier.id
}

output "private_subnet_ids_frontend" {
  value = [aws_subnet.prvt3.id, aws_subnet.prvt4.id]
}

output "private_subnet_ids_backend" {
  value = [aws_subnet.prvt5.id, aws_subnet.prvt6.id]
}
output "public_subnet_1_id" {
  value = [aws_subnet.pub1.id]
}

output "public_subnet_2_id" {
  value = [aws_subnet.pub2.id]
}
output "public_subnet_ids" {
  value = [aws_subnet.pub1.id, aws_subnet.pub2.id]
}
output "rds_subnet_ids" {
  value = [aws_subnet.prvt7.id, aws_subnet.prvt8.id]
  
}