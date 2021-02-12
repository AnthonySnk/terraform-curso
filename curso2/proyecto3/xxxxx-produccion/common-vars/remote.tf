terraform {
  backend "s3" {
    bucket = "terrafrom-states-snk"
    key    = "testing/common-vars/state.tfstate"
    region = "us-east-1"
  }
}
