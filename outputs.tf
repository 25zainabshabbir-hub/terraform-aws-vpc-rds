output "vpc_id" { value = module.network.vpc_id }
output "db_endpoint" { value = module.database.db_endpoint }

#After apply, Terraform prints these. That's how you saw the DB endpoint. A module's output isn't visible from 
#the root unless the root re-exposes it like this.

output "web_public_ip" {
  value = module.compute.public_ip
}