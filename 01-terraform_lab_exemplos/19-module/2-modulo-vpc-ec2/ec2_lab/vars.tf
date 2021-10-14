variable nome {
  type = string
  description = "Digite o nome da instancia"
}

variable vpc_id {
  type = string
  description = "Id da VPC"
}

variable config {
  type = list(object({Tipo = string, Nome = string, SubnetId = string}))
  description = "Configuração de tamanho das máquinas"
}