terraform {
  backend "s3" {
    bucket  = "fiap-fastfood-terraform-state-lgrando"
    key     = "atlas/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}