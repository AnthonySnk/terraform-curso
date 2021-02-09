variable "bucket_name" {
  default     = "backend-terraform-snk"
  description = "Nombre del bucket"
}
variable "acl" {
  default = "private"
}
variable "tags" {
  default = {
    Environment = "Dev"
    CreateBy    = "Terraform"
  }
}
