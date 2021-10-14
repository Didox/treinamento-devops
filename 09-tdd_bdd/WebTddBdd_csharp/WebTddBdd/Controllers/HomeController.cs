using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using WebTddBdd.Models;

namespace WebTddBdd.Controllers
{
    public class HomeController : Controller
    {
        [Route("/")]
        public IActionResult Index()
        {
            return View();
        }
        
        [Route("/valida-cpf")]
        [HttpPost]
        public IActionResult ValidateCPF([FromForm] Cliente cliente)
        {
            var listaDynamic = new List<dynamic>();

            listaDynamic.Add("string")
            listaDynamic.Add("string")
            listaDynamic.Add("string")
            listaDynamic.Add("string")

            var lista = new List<Cliente>();

            lista.Add(new Cliente() {
                Id = 0,
                Nome = "Willian"
            })
            lista[0].Nome
            lista[0].Id

            ViewBag.isCPFValid = cliente.ValidaCpf();
            ViewBag.nome = cliente.Nome;
            return View();
        }
    }
}
