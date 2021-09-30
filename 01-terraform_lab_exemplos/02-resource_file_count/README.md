*** Cria um arquivo gerenciado pelo terraform

```tf
resource "local_file" "teste" {
  filename = "teste1.txt"
  content = "Olá alunos bem vindo ao terraform 1.0"
}
```