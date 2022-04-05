var express = require('express');
var router = express.Router();

const PessoaJuridica = require("../models/pessoa_juridica")

/* GET home page. */
router.get('/', function(req, res, next) {

  let validado = ""
  let cnpj = req.query.cnpj
  if(cnpj)
    validado = new PessoaJuridica("", req.query.cnpj).validarCNPJ()
  
  res.render('index', { cnpj: cnpj, validado: validado });
});

module.exports = router;
