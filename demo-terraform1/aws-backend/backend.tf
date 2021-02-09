# terraform {
##Sin incripotacion
#   backend "s3" {
#     bucket = "backend-terraform-snk"
#     key    = "Dev"
#     region = "us-east-1"
#   }
# }

terraform {
  backend "s3" {
    bucket        = "backend-terraform-dahwild"
    key           = "dev"
    region        = "us-east-1"
    # encrypt       = true
    # kms_key_id    = "arn:aws:kms:us-east-2:511857092531:key/35f69747-5431-43eb-8897-4901a1c1b478" 
  }

}
