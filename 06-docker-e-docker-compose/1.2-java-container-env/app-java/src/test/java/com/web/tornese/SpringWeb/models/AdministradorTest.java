package com.web.tornese.SpringWeb.models;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.web.tornese.SpringWeb.repositorio.AdministradoresRepo;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class AdministradorTest {
  @Autowired
  private AdministradoresRepo repo;

  @Test
	void salvaAdmNoBancoDeDados() {
    limpaCriaUsuario();
    assertEquals(1, repo.count());
	}

  @Test
	void atualizaRegistro() {
    Administrador adm = limpaCriaUsuario();

    String novaSenha = "123456";
    adm.setSenha(novaSenha);
    repo.save(adm);

    assertEquals(novaSenha, repo.findById(adm.getId()).get().getSenha());
	}

  @Test
	void buscaLoginSenha() {
    Administrador adm = limpaCriaUsuario();
    assertEquals(true, repo.Login(adm.getEmail(), adm.getSenha()) != null);
	}

  @Test
	void existePorId() {
    Administrador adm = limpaCriaUsuario();
    assertEquals(true, repo.exist(adm.getId()));
	}

  @Test
	void apagarUsuario() {
    Administrador adm = limpaCriaUsuario();
    repo.delete(adm);
    assertEquals(0, repo.count());
	}

  private Administrador limpaCriaUsuario() {
    repo.deleteAll(repo.findAll());

    Administrador adm = new Administrador();
    adm.setNome("Danilo");
    adm.setEmail("danilo@torneseumprogramador.com.br");
    adm.setSenha("ddd19291ms");
    adm.setObservacao("um teste de unidade");
    repo.save(adm);

    return adm;
  }

}
