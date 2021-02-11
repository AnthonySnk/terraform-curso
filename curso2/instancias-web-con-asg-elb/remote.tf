terraform {
  backend "s3" {
    bucket = "terrafrom-states-snk"
    key    = "terraform/web_interface.tfstate"
    region = "us-east-1"
    dynamodb_table = "TerraformLock"
  }
}