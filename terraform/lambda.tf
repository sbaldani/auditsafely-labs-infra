data "archive_file" "scan_events_handler" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/scan_events_handler.zip"
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.project_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name    = "${var.project_name}-lambda-role"
    Project = var.project_name
  }
}

resource "aws_iam_role_policy" "lambda_exec_permissions" {
  name = "${var.project_name}-lambda-policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CloudWatchLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Sid    = "SQSConsume"
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.scan_events.arn
      }
    ]
  })
}

resource "aws_lambda_function" "scan_events_handler" {
  function_name    = "${var.project_name}-scan-events-handler"
  role             = aws_iam_role.lambda_exec.arn
  filename         = data.archive_file.scan_events_handler.output_path
  source_code_hash = data.archive_file.scan_events_handler.output_base64sha256
  runtime          = "nodejs20.x"
  handler          = "index.handler"

  tags = {
    Name    = "${var.project_name}-scan-events-handler"
    Project = var.project_name
  }
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.scan_events.arn
  function_name    = aws_lambda_function.scan_events_handler.arn
  batch_size       = 1
  enabled          = true
}
