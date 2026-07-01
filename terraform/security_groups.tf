resource "aws_security_group" "main" {
  name        = "${var.project_name}-sg"
  description = "AuditSafely Labs - SSH restricted to developer IP, HTTP/HTTPS public"

  # SSH — your IP only
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.your_ip_cidr]
  }

  # HTTP — public (nginx serves on 80)
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS — public (ready for when you add SSL)
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Backend direct access — your IP only
  ingress {
    description = "NestJS backend"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.your_ip_cidr]
  }

  # Frontend direct access — your IP only
  ingress {
    description = "Next.js frontend"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [var.your_ip_cidr]
  }

  # Allow all outbound — instance needs to reach npm, GitHub, AWS APIs
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}
