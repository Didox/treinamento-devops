
variable "idade" {
  type        = number
  description = "Qual é a sua idade?"
}

variable "nome" {
  type        = string
  description = "Qual é o seu nome"
}

output "idade" {
  value       = var.idade
  description = "Sua idade"
}

output "nome" {
  value       = var.nome
  description = "Seu nome"
}