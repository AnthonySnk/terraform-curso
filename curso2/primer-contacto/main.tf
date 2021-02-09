resource "aws_instance" "web" {
  ami           = "ami-03d315ad33b9d49c4"
  instance_type = "t2.micro"
  key_name = "master-key"
  tags = {
    "Name" = "Instance-curso-2"
  }
}
