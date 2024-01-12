output "rds_endpoint" {
  description = "The domain-name of the RDS endpoint"
  value       = aws_db_instance.default.endpoint
}
