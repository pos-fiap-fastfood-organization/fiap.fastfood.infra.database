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
resource "mongodbatlas_advanced_cluster" "fastfood_cluster" {
  project_id   = mongodbatlas_project.project.id
  name         = "fastfood-cluster"
  cluster_type = "REPLICASET"

  replication_specs {
    region_configs {
      electable_specs {
        instance_size = "M0"
      }
      provider_name         = "TENANT"
      backing_provider_name = "AWS"
      region_name           = "US_EAST_1"
      priority              = 7
    }
  }
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

  roles {
    role_name     = "dbAdmin"
    database_name = "fiap_fastfood"
  }
}

# Liberar acesso a máquina (IP público) 
resource "mongodbatlas_project_ip_access_list" "access" {
  project_id = mongodbatlas_project.project.id
  cidr_block = "0.0.0.0/0"
  comment    = "Acesso liberado para dev/teste"
}