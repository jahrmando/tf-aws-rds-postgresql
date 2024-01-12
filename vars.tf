variable "master_username" {
  description = "The database master username."
  type        = string
}

variable "master_password" {
  description = "The database master username's password."
  type        = string
}

variable "service_port" {
  description = "The RDS port to connect."
  type        = number
  default     = 5432
}

variable "publicly_accessible" {
  description = "Boolean value to make RDS publicly accessible."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Boolean value to skip final snapshot."
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Boolean value to enable deletion protection."
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Boolean value to apply changes immediately."
  type        = bool
  default     = false
}

variable "env" {
  description = "The environmet name where RDS will be created."
  type        = string
}

variable "project" {
  description = "The project name."
  type        = string
}

variable "instance_class" {
  description = "The instance_class for RDS."
  type        = string
  default     = "db.t4g.micro"
}

variable "engine" {
  description = "The RDS engine."
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The RDS engine version."
  type        = string
  default     = "12.16"
}

variable "copy_tags_to_snapshot" {
  description = "Boolean value to copy all the tags from RDS to snapshots."
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = 60
}

variable "multi_az" {
  description = "Boolean variable to specify if the RDS instance is multi-AZ (Multi available zones)."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The amount of days of backup retention."
  type        = number
  default     = 1
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled."
  type        = string
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. [ddd:hh24:mi-ddd:hh24:mi]"
  type        = string
}
