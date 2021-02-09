output "instance_ip" {
  value=aws_instance.demo-parametrizado.*.public_ip
}
