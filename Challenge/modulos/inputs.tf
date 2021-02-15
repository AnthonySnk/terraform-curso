variable "ami" {
  description = "AMI a instalar"
}
variable "environment" {
  description = "El ambiente de creacion"
}
variable "instance_type" {
  default     = "t2.micro"
  description = "Tipo de instancias"
}
variable "project_name" {
  description = "Nombre del proyecto"
}
variable "key_name" {
  description = "La key de acceso a las EC2"
}
variable "main_vpc" {
  default     = "192.168.0.0/16"
  description = "LA vpc principal"
}
variable "public_1" {
  type        = list(any)
  default     = ["192.168.10.0/24"]
  description = "Valor de la primera red publica"
}
variable "public_2" {
  type        = list(any)
  default     = ["192.168.11.0/24"]
  description = "Valor de la segunda red publica"
}
variable "public_3" {
  type        = list(any)
  default     = ["192.168.12.0/24"]
  description = "Valor de la tercera red publica"
}

variable "private_1" {
  type        = list(any)
  default     = ["192.168.20.0/24"]
  description = "Valor de la primera red privada"
}
variable "private_2" {
  type        = list(any)
  default     = ["192.168.21.0/24"]
  description = "Valor de la segunda red privada"
}
variable "private_3" {
  type        = list(any)
  default     = ["192.168.22.0/24"]
  description = "Valor de la tercera red privada"
}
variable "ingress_rules" {
  type        = list(any)
  description = "Ingress para el vpn"
}