const PessoaJuridica = require("../models/pessoa_juridica")

test('Dado que eu passei um CNPJ falso, deveria dar o retorno inválido', () => {
  expect(new PessoaJuridica("Lbt Bras", "1111").validarCNPJ()).toBe(false);
});

test('Dado que eu passei um CNPJ válido, deveria dar o retorno true', () => {
  expect(new PessoaJuridica("Lbt Bras", "90.314.635/0001-56").validarCNPJ()).toBe(true);
});

test('Dado que eu passei um CNPJ válido sem máscara, deveria dar o retorno true', () => {
  expect(new PessoaJuridica("Lbt Bras", "90314635000156").validarCNPJ()).toBe(true);
});

test('Dado que eu passei um CNPJ inválido sem máscara, deveria dar o retorno false', () => {
  expect(new PessoaJuridica("Lbt Bras", "90314635000151").validarCNPJ()).toBe(false);
});