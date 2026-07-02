resource "aws_sqs_queue" "scan_events_dlq" {
  name                      = "${var.project_name}-scan-events-dlq"
  message_retention_seconds = 1209600

  tags = {
    Name    = "${var.project_name}-scan-events-dlq"
    Project = var.project_name
  }
}

resource "aws_sqs_queue" "scan_events" {
  name                       = "${var.project_name}-scan-events"
  visibility_timeout_seconds = 60
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.scan_events_dlq.arn
    maxReceiveCount     = 3
  })

  tags = {
    Name    = "${var.project_name}-scan-events"
    Project = var.project_name
  }
}
