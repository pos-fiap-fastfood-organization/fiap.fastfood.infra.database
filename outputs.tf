output "mongodb_connection_string" {
  description = "Connection string padrão do cluster"
  value       = mongodbatlas_advanced_cluster.fastfood_cluster.connection_strings[0].standard
}

output "mongodb_user" {
  value = mongodbatlas_database_user.fastfood_user.username
}

output "mongodb_database" {
  value = "fiap_fastfood"
}