resource "aws_eip" "web-eip" {
  instance = aws_instance.web.id
  vpc      = true
}