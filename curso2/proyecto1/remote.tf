terraform {
  backend "s3" {
    bucket = "terrafrom-states-snk"
    key    = "terraform/project1.tfstate"
    region = "us-east-1"
  }
}
