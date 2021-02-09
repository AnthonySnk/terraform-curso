ami_id        = "ami-047a51fa27710816e"
instance_type = "t2.micro"
tags = {
  Name        = "Practica-parametrizada",
  Environment = "Dev"
}
sg_name = "SSH-allowed"
#un array para que el main pueda recorrerlos
ingress_rules = [
  {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
