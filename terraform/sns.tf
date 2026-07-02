resource "aws_sns_topic" "events" {
  name = "${var.project_name}-events"

  tags = {
    Name    = "${var.project_name}-events"
    Project = var.project_name
  }
}

resource "aws_sns_topic_subscription" "scan_events_sqs" {
  topic_arn = aws_sns_topic.events.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.scan_events.arn
}

resource "aws_sqs_queue_policy" "scan_events" {
  queue_url = aws_sqs_queue.scan_events.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.scan_events.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.events.arn
          }
        }
      }
    ]
  })
}
