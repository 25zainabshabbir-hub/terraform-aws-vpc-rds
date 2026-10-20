resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnets"
  subnet_ids = var.private_subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "db" {
  name   = "${var.name}-db-sg"
  vpc_id = var.vpc_id
  tags   = merge(var.tags, { Name = "${var.name}-db-sg" })
}

# Only the public subnet range can reach MySQL
resource "aws_vpc_security_group_ingress_rule" "mysql" {
  security_group_id = aws_security_group.db.id
  cidr_ipv4         = var.allowed_cidr
  from_port         = 3306
  to_port           = 3306
  ip_protocol       = "tcp"
}

resource "aws_db_instance" "this" {
  identifier             = "${var.name}-db"
  engine                 = "mysql"
  instance_class         = var.instance_class
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false
  skip_final_snapshot    = true # lab only; remove for real environments

  # AWS creates and stores the password in Secrets Manager,
  # so there is no password in your code
  password = var.db_password

  tags = var.tags
}