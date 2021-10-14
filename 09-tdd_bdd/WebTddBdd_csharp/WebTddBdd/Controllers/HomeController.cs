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
            ViewBag.isCPFValid = cliente.ValidaCpf();
            ViewBag.nome = cliente.Nome;
            return View();
        }
    }
}
