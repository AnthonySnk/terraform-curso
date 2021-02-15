module "challenge" {
  source        = "./modulos"
  ami           = "ami-0be2609ba883822ec"
  environment   = "dev"
  instance_type = "t2.micro"
  project_name  = "reto-Terraform"
  key_name      = "master-key"
  ingress_rules = [
    {
      #por cuestiones de prueba para la conexion ssh al VPN
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = "943"
      to_port     = "943"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = "443"
      to_port     = "443"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = "1194"
      to_port     = "1194"
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

}
