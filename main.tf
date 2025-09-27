provider "mongodbatlas" {
  public_key  = var.atlas_public_key
  private_key = var.atlas_private_key
}

# Projeto no Atlas
resource "mongodbatlas_project" "project" {
  name   = var.atlas_project_name
  org_id = var.atlas_org_id
}

# Cluster MongoDB
resource "mongodbatlas_cluster" "fastfood_cluster" {
  project_id                  = mongodbatlas_project.project.id
  name                        = "fastfood-cluster"
  provider_name               = "AWS"
  backing_provider_name       = "AWS"
  provider_region_name        = "US_EAST_2"
  provider_instance_size_name = "M0" # Free tier
  mongo_db_major_version      = "7.0"
}

# Usuário do banco
resource "mongodbatlas_database_user" "fastfood_user" {
  project_id         = mongodbatlas_project.project.id
  username           = "fastfood_user"
  password           = var.fastfood_user_password
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "fiap_fastfood"
  }
}

# Liberar acesso a máquina (IP público) 
resource "mongodbatlas_project_ip_access_list" "access" {
  project_id = mongodbatlas_project.project.id
  cidr_block = "0.0.0.0/0"
  comment    = "Acesso liberado para dev/teste"
}