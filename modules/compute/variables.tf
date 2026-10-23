variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_cidr" {
  type        = string
  description = "Your IP in CIDR form, e.g. 203.0.113.10/32"
}

variable "ssh_public_key" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "tags" {
  type    = map(string)
  default = {}
}