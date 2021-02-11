resource "aws_eip" "eip" {
  vpc      = true
  instance = aws_instance.web.id
  tags = {
    "Name" = "EIP-${var.project_name}-${var.environment}"
  }
}
