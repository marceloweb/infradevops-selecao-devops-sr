variable "environment" {
  description = "The deployment environment (e.g., dev, prd)."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the database will be created."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the database."
  type        = list(string)
}

variable "db_username" {
  description = "Database master username."
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database master password."
  type        = string
  default     = "password"
  sensitive   = true
}

variable "db_name" {
  description = "The name of the database to be created."
  type        = string
  default     = "comments_db"
}

variable "db_engine_version" {
  description = "The engine version of the database."
  type        = string
  default     = "13.6"
}