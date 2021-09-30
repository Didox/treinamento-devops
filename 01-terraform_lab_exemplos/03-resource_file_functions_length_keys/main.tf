variable "arquivos" {
  default     = {
    arquivo1 = "Primeiro item",
    arquivo2 = "Segundo item",
    arquivo3 = <<EOF

Terceiro item com vários linhas de dados
Bla blla

EOF
  }
}

# Forma grande
resource "local_file" "map_files" {
  count = length(keys(var.arquivos))
  filename = "${keys(var.arquivos)[count.index]}.txt"
  content = var.arquivos[keys(var.arquivos)[count.index]]
}

# Forma reduzida
# resource "local_file" "map_files" {
#   for_each = var.arquivos
#   filename = each.key
#   content = each.value
# }