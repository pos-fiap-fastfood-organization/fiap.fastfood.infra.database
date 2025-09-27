variable "atlas_public_key" {
  description = "MongoDB Atlas public API key"
  type        = string
}

variable "atlas_private_key" {
  description = "MongoDB Atlas private API key"
  type        = string
  sensitive   = true
}

variable "atlas_org_id" {
  description = "MongoDB Atlas Organization ID"
  type        = string
}

variable "atlas_project_name" {
  description = "Nome do projeto MongoDB Atlas"
  type        = string
  default     = "fiap-fastfood"
}