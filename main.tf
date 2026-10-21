locals {
  name = "${var.project}-${var.environment}"
  tags = {
    Project     = var.project
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

#locals are named values reused inside the code. Here: one naming prefix and one common tags map, so every 
#resource gets consistent names and tags.

module "network" {
  source               = "./modules/network"
  name                 = local.name
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
  tags                 = local.tags
}

module "database" {
  source             = "./modules/database"
  name               = local.name
  vpc_id             = module.network.vpc_id             # output → input
  private_subnet_ids = module.network.private_subnet_ids # output → input
  allowed_cidr       = module.network.public_subnet_cidr
  db_name            = "appdb"
  db_username        = "admin_user"
  tags               = local.tags
  db_password        = var.db_password
}

#Each module block means: "go to that folder, run its code, and use these values as its inputs." The key idea 
#is the lines with module.network.xxx: the network module's outputs feed the database module's inputs. That is 
#also how Terraform knows to build the network first and the database second (an implicit dependency)