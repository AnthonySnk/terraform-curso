data "aws_route53_zone" "selected" {
  name = "nelson-sanchez-snk.com"
  private_zone = false
}