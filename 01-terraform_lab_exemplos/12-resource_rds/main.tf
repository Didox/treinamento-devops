provider "aws" {
  region = "us-east-1"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance

resource "aws_db_instance" "default" {
  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  name           = "danilo_db"
  username       = "danilouser"
  password       = "danilopass"
  allocated_storage = 5 # aloca 5 GiB
  publicly_accessible = true # libera acesso publico
  vpc_security_group_ids = ["${aws_security_group.acesso_mysql.id}"]
  backup_retention_period = 0 # não criar backup periódico
  # preferred_backup_window = "07:00-09:00" # hora que vai realizar o backup
  deletion_protection = false # não protegido para exclusão
  skip_final_snapshot = true # não criar snapshot - caso de o erro "Error: DB Instance FinalSnapshotIdentifier is required when a final snapshot is required"
  # final_snapshot_identifier = true # caso de o erro "Error: DB Instance FinalSnapshotIdentifier is required when a final snapshot is required"
  tags = {
    Name = "meu mysql"
  }
}