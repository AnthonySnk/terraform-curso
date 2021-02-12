terraform {
  backend "s3" {
    bucket = "terrafrom-states-snk"
     key    = "testing/vpc/state.tfstate"
    region = "us-east-1"
  }
}
data "terraform_remote_state" "common" {
  backend = "s3"
  config {
    bucket = "terraform-vcc-ep-15"
    key    = "testing/common-vars/state.tfstate"
    region = "us-east-1"
  }
}