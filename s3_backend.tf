terraform {
  backend "s3" {
    bucket  = "fiap-fastfood-terraform-state"
    key     = "atlas/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}