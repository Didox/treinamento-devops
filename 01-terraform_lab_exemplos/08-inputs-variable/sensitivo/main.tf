variable "senha_super_secreta" {
    type = string
    sensitive = true
    description = "Digite a senha secreta"
}

output "senha_super_secreta" {
    value = var.senha_super_secreta
    sensitive = true
}