package com.validar.cpf.validadorCPF.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.validar.cpf.validadorCPF.models.Cliente;

@Controller
public class HomeController {
    @GetMapping("/")
    public String index(){
      return "home/index";
    }

    @PostMapping("/valida-cpf")
    public String validarCpf(Cliente cliente, Model model){
      model.addAttribute("cliente", cliente);
      model.addAttribute("validado", cliente.validarCPF());
      return "home/cpfValidado";
    }

}
