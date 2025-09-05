resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group-${var.environment}"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "DB Subnet Group - ${var.environment}"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db-sg-${var.environment}"
  description = "Allow inbound traffic from EKS cluster."
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "db_ingress" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.db_sg.id
  source_security_group_id = var.eks_cluster_security_group_id 
  description              = "Allow traffic from EKS cluster."
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = var.db_engine_version
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible  = false

  tags = {
    Name = "Postgres DB - ${var.environment}"
  }
}