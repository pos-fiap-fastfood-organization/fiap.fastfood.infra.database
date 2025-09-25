# Pega os outputs do infra-eks
data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "fiap-fastfood-terraform-state"
    key    = "eks/terraform.tfstate"
    region = "us-east-2"
  }
}

# Security Group para DocumentDB
resource "aws_security_group" "docdb_sg" {
  name        = "docdb-sg"
  description = "Allow access to DocumentDB"
  vpc_id      = data.terraform_remote_state.eks.outputs.vpc_id

  ingress {
    description = "Allow MongoDB access from VPC"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.eks.outputs.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "docdb-sg"
  }
}

# Subnet Group para DocumentDB
resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "fiap-fastfood-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.eks.outputs.private_subnets

  tags = {
    Name = "fiap-fastfood-docdb-subnet-group"
  }
}

# Cluster DocumentDB
resource "aws_docdb_cluster" "docdb_cluster" {
  cluster_identifier     = "fiap-fastfood-docdb"
  master_username        = "fastfood_user"
  master_password        = "Fastfood2025"
  database_name          = "fiap_fastfood"
  engine                 = "docdb"
  engine_version         = "5.0.0"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_docdb_subnet_group.docdb_subnet_group.name
  vpc_security_group_ids = [aws_security_group.docdb_sg.id]

  tags = {
    Name = "fiap-fastfood-docdb"
  }
}

# Instância do Cluster
resource "aws_docdb_cluster_instance" "docdb_instance" {
  count              = 1
  identifier         = "fiap-fastfood-docdb-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb_cluster.id
  instance_class     = "db.t3.medium"

  tags = {
    Name = "fiap-fastfood-docdb-instance"
  }
}
