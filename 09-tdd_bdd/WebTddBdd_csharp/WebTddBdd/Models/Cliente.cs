using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace WebTddBdd.Models
{
  [Table("Clientes")]
  public class Cliente
  {
    public int Id { get; set; }
    public string Nome { get; set; }
    public string CPF { get; set; }

    public bool ValidaCpf()
    {
      string cpf = this.CPF;
      int[] multiplicador1 = new int[9] { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
      int[] multiplicador2 = new int[10] { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };
      string tempCpf;
      string digito;
      int soma;
      int resto;
      cpf = cpf.Trim();
      cpf = cpf.Replace(".", "").Replace("-", "");
      if (cpf.Length != 11)
        return false;
      tempCpf = cpf.Substring(0, 9);
      soma = 0;

      for (int i = 0; i < 9; i++)
        soma += int.Parse(tempCpf[i].ToString()) * multiplicador1[i];
      resto = soma % 11;
      if (resto < 2)
        resto = 0;
      else
        resto = 11 - resto;
      digito = resto.ToString();
      tempCpf = tempCpf + digito;
      soma = 0;
      for (int i = 0; i < 10; i++)
        soma += int.Parse(tempCpf[i].ToString()) * multiplicador2[i];
      resto = soma % 11;
      if (resto < 2)
        resto = 0;
      else
        resto = 11 - resto;
      digito = digito + resto.ToString();
      return cpf.EndsWith(digito);
    }

    public void Save()
    {
      var context = new DBContextWeb();
      context.Clientes.Add(this);
      context.SaveChanges();
    }

    public static DbSet<Cliente> All()
    {
      return new DBContextWeb().Clientes;
    }

    public static void DestroyAll()
    {
      var dbContext = new DBContextWeb();
      dbContext.Database.ExecuteSqlRaw("delete from clientes");
    }
  }
}
