output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.my_server.id
}

output "public_ip" {
    description = "Public IP to SSH into"
    value       = aws_instance.my_server.public_ip
}

output "dynamodb_table_name" {
    description = "Name of the created DynamoDB table"
    value       = aws_dynamodb_table.practice_table.name
}

output "dynamodb_table_arn" {
    description = "ARN of the DynamoDB table"
    value       = aws_dynamodb_table.practice_table.arn
}