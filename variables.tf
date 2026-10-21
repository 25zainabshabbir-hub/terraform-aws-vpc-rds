variable "region" {
  type    = string
  default = "eu-north-1"
}
variable "project" {
  type    = string
  default = "demo"
}
variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be dev, staging or prod."
  }
}
variable "db_password" {
  type      = string
  sensitive = true
}