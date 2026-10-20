terraform {
  backend "s3" {
    bucket       = "tfstate-954935267955-eu-north-1"
    key          = "vpc-rds/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}