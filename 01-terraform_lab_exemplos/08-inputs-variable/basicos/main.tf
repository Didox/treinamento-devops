// variable <name>
variable "pais" {
  type        = string
  default     = "Brasil"
  description = "Em qual país você está?"
}

variable "idade" {
  type        = number
  description = "Qual é a sua idade?"
}

variable "vai_meu" {
  type        = bool
  default     = false
  description = "Vai meu?"
}

# // output <name>
# output "pais" {
#   value       = var.pais
#   description = "Seu país"
# }

# output "idade" {
#   value       = var.idade
#   description = "Sua idade"
# }

# output "vai_meu" {
#   value       = var.vai_meu
#   description = "rápido, pedala !"
# }