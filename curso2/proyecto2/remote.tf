terraform {
  backend "s3" {
    bucket = "terrafrom-states-snk"
    key    = "terraform/project2.tfstate"
    region = "us-east-1"
  }
}

#Para acceder a output de otros poyectos
data "terraform_remote_state" "project1" {
  backend = "s3"
  config = {
    bucket = "terrafrom-states-snk"
    key    = "terraform/project1.tfstate"
    region = "us-east-1"
  }
}
