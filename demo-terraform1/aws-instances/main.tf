provider "aws" {
  shared_credentials_file = "/Users/tfsvr/.aws/credentials"
  region = "us-east-1"
}
resource "aws_instance" "demo-instance" {
  #   colocar todos los parametros aqui 
  ami           = "ami-047a51fa27710816e"
  instance_type = "t2.micro"
  tags = {
    Name        = "practica1"
    Environment = "Dev"
  }
}
