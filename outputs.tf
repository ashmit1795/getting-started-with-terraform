output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.my_server.id
}

output "public_ip" {
  description = "Public IP to SSH into"
  value       = aws_instance.my_server.public_ip
}