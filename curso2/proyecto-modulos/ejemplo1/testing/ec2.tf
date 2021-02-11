module "ec2" {
  source        = "../../modulo-ec2-with-eip/"
  vpc_id        = data.aws_vpc.selected.id
  environment   = "testing"
  project_name  = "web"
  ami           = "ami-03d315ad33b9d49c4"
  instance_type = "t2.micro"
  key_name      = "master-key"
}
