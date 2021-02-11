resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "web.nelson-sanchez-snk.com"
  type    = "A"
  ttl     = "300"
  records = [data.terraform_remote_state.project1.outputs.web_public_EIP] #Ip traida de otro projecto
}