output "public_ip" {
  value = aws_instance.Server1.public_ip

}
output "private_ip" {
  value = aws_instance.Server1.private_ip
}