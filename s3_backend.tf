terraform {
  backend "s3" {
    bucket  = "fiap-fastfood-terraform-state"
    key     = "docdb/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}