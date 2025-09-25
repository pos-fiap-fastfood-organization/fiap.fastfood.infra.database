output "docdb_endpoint" {
  value = aws_docdb_cluster.docdb_cluster.endpoint
}

output "docdb_port" {
  value = aws_docdb_cluster.docdb_cluster.port
}

output "docdb_user" {
  value = aws_docdb_cluster.docdb_cluster.master_username
}

output "docdb_database" {
  value = aws_docdb_cluster.docdb_cluster.database_name
}