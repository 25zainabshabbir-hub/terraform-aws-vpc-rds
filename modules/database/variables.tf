variable "name" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "allowed_cidr" { type = string } # who may connect to the DB
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "db_password" {
  type      = string
  sensitive = true
}