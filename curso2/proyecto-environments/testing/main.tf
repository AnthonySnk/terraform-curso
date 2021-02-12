module "webServer" {
  source        = "github.com/videocursoscloud/terraform-module-ec2-with-eip?ref=v1.0.2"
  ami           = "ami-03d315ad33b9d49c4"
  instance_type = "t2.micro"
  key_name      = "master-key"
  vpc_id        = data.aws_vpc.selected.id
  project_name  = "web-server"
  environment   = "testing"
}
