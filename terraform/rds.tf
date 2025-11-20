resource "aws_db_subnet_group" "rds_subnets" {
  name       = "rds-subnets"
  subnet_ids = aws_subnet.private[*].id
  tags = {
    Name    = "RDS Subnets"
    Owner   = var.owner
    Project = var.project
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "postgres-db"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "wordpress"
  username               = var.rds_username
  password               = var.rds_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  tags = {
    Name    = "RDS-Postgres-alejandro"
    Owner   = var.owner
    Project = var.project
  }
}
