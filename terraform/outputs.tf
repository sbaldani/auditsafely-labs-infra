output "instance_public_ip" {
  description = "Elastic IP assigned to the EC2 instance"
  value       = aws_eip.main.public_ip
}

output "instance_id" {
  description = "EC2 instance ID — useful for the AWS console"
  value       = aws_instance.main.id
}

output "ssh_command" {
  description = "Ready-to-run SSH command"
  value       = "ssh -i ~/.ssh/auditsafely-labs ubuntu@${aws_eip.main.public_ip}"
}

output "backend_url" {
  description = "Backend API base URL"
  value       = "http://${aws_eip.main.public_ip}/api-v753"
}

output "swagger_url" {
  description = "Swagger docs URL"
  value       = "http://${aws_eip.main.public_ip}/api-v753/docs"
}
