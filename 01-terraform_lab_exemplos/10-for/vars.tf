variable "colaboradores" {
  default     = {
    danilo = {
      admin = true,
      email = "danilo@torneseumprogramador.com.br",
      cargo = "fundador",
    },
    daniel = {
      admin = true,
      email = "daniel@torneseumprogramador.com.br",
      cargo = "administrador",
    },
    thiago = {
      admin = false,
      email = "thiago@torneseumprogramador.com.br",
      cargo = "atendimento e suporte",
    },
  }
}