resource "local_file" "teste" {
  count = 3
  filename = "teste${count.index}.txt"
  content = "Olá alunos bem vindo ao terraform ${count.index}.0"
}