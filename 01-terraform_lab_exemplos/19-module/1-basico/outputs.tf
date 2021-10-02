output "files" {
  value = [for filename, data in module.objects : filename]
}
