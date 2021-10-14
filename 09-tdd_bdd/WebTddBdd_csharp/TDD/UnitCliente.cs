using NUnit.Framework;
using System.Linq;
using WebTddBdd.Models;

namespace TDD
{
    public class Tests
    {
        [SetUp]
        public void Setup()
        {
            //Cliente.DestroyAll();
        }

        [Test]
        public void ValidaCpfValido()
        {
            var cliente = new Cliente();
            cliente.CPF = "793.608.890-32";
            Assert.IsTrue(cliente.ValidaCpf());
        }

        [Test]
        public void ValidaCpfInvalido()
        {
            var cliente = new Cliente();
            cliente.CPF = "793.608.890-33";
            Assert.IsFalse(cliente.ValidaCpf());
        }

        /*[Test]
        public void CadastraNovoCliente()
        {
            var cliente = new Cliente();
            cliente.Nome = "Danilo";
            cliente.CPF = "793.608.890-33";
            cliente.Save();

            Assert.AreEqual(1, Cliente.All().Count());
        }*/
    }
}