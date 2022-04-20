resource "aws_db_instance" "rds" {
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t2.micro"
  db_name = "db_mysql_desafio"
  username = "root"
  password = var.senha
  allocated_storage = 5
  publicly_accessible = false

  vpc_security_group_ids = [
    aws_security_group.libera_mysql.id
  ]

  backup_retention_period = 0
  # preferred_backup_window = "01:00-05:00"
  deletion_protection = false
  skip_final_snapshot = true

  tags = {
    "Name" = "rds-mysql-desafio"
  }
}

# TF_VAR_senha_rds="danilosenha" terraform apply -auto-approve