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

output "sns_topic_arn" {
  description = "SNS topic ARN — used by NestJS to publish events"
  value       = aws_sns_topic.events.arn
}

output "sqs_queue_url" {
  description = "SQS queue URL — useful for manual testing and debugging"
  value       = aws_sqs_queue.scan_events.url
}

output "sqs_dlq_url" {
  description = "Dead-letter queue URL — inspect failed messages here"
  value       = aws_sqs_queue.scan_events_dlq.url
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.scan_events_handler.function_name
}
