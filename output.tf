output "ec2_pubil_id" {
  value = aws_instance.terra_instance.public_ip
}
output "ec2_pubil_dns" {
  value = aws_instance.terra_instance.public_dns
}