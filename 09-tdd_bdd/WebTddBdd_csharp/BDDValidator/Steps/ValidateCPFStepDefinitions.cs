using System;
using System.IO;
using System.Threading;
using NUnit.Framework;
using OpenQA.Selenium.Chrome;
using TechTalk.SpecFlow;

namespace BDDValidator.Steps
{
    [Binding]
    public sealed class ValidateCPFStepDefinitions
    {
        private ChromeDriver _chromeDriver;

        private readonly ScenarioContext _scenarioContext;

        public ValidateCPFStepDefinitions(ScenarioContext scenarioContext)
        {
            _scenarioContext = scenarioContext;
            string path =new DirectoryInfo(Environment.CurrentDirectory).Parent.Parent.FullName;
            // _chromeDriver = new ChromeDriver(path + @"\..\Drivers\windows");
            _chromeDriver = new ChromeDriver( path + @"/../Drivers/mac");
        }

        [Given(@"i'm in home page")]
        public void GivenImInHomePage()
        {
            _chromeDriver.Url = "https://localhost:5001/";
        }

        [Given(@"I type the CPF ""(.*)""")]
        public void GivenITypeTheCPF(string cpf)
        {
            _chromeDriver.FindElementByCssSelector("#Nome").SendKeys("Danilo BDD");
            Thread.Sleep(1000);
            _chromeDriver.FindElementByCssSelector("#CPF").SendKeys(cpf);
            Thread.Sleep(1000);
        }

        [When(@"I click on button validate")]
        public void WhenIClickOnButtonValidate()
        {
            _chromeDriver.FindElementByCssSelector("input[type='submit']").Click();
            Thread.Sleep(1000);
        }

        [Then(@"I have the successful result")]
        public void ThenIHaveTheSuccessfulResult()
        {
            Assert.IsTrue(_chromeDriver.FindElementsByCssSelector(".alert-success").Count > 0);
            Thread.Sleep(1000);
            _chromeDriver.Close();
            _chromeDriver.Dispose();
        }

        [Given(@"I type the CPF ""(.*)"" invalid")]
        public void GivenITypeTheInvalidCPF(string cpf)
        {
            _chromeDriver.FindElementByCssSelector("#Nome").SendKeys("Danilo BDD");
            Thread.Sleep(1000);
            _chromeDriver.FindElementByCssSelector("#CPF").SendKeys(cpf);
            Thread.Sleep(1000);
        }

        [Then(@"I have the error result")]
        public void ThenIHaveTheErrorfulResult()
        {
            Assert.IsTrue(_chromeDriver.FindElementsByCssSelector(".alert-danger").Count > 0);
            Thread.Sleep(1000);
            _chromeDriver.Close();
            _chromeDriver.Dispose();
        }
    }
}
