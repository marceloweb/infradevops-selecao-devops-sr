output "db_endpoint" {
  description = "The endpoint of the RDS instance."
  value       = aws_db_instance.postgres.address
}

output "db_username" {
  description = "The database username."
  value       = aws_db_instance.postgres.username
}

output "db_password" {
  description = "The database password."
  value       = aws_db_instance.postgres.password
  sensitive   = true
}

output "db_name" {
  description = "The database name."
  value       = aws_db_instance.postgres.db_name
}