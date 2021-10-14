using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace WebTddBdd.Models
{
    public class DBContextWeb: DbContext
    {
        public DBContextWeb(DbContextOptions options) : base(options)
        {
        }

        public DBContextWeb() { }

        public DbSet<Cliente> Clientes { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            JToken jAppSettings = JToken.Parse(File.ReadAllText(Path.Combine(Environment.CurrentDirectory,"appsettings.json")));

            optionsBuilder.UseSqlServer(jAppSettings["ConnectionStrings"]["DefaultConnection"].ToString());
        }
    }
}
