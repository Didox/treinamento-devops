output "dados_da_variavel" {
  value = [
    for item in var.colaboradores :
      "${item.cargo} - ${item.email}"
      if item.admin # filtra domente quem é administrador
      # if item.cargo == "fundador" # filtra domente quem é administrador
  ]
}

output "dados_da_variavel_key" {
  value = [
    for key, item in var.colaboradores :
      "${key} - ${item.cargo} - ${item.email}"
  ]
}

output "dados_da_variavel_map" {
  value = {
    for key, val in var.colaboradores :
    val.email => {
      "user_name" : key
      "cargo" : val.cargo
      "admin" : val.admin
    }
  }
}

output "dados_da_variavel_key2" {
  value = [
    for key, item in var.colaboradores :
      <<EOF

      ${key}
      ${item.cargo}
      ${item.email}

      EOF
  ]
}
