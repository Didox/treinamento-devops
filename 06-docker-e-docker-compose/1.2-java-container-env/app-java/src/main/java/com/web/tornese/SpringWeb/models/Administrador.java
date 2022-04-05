package com.web.tornese.SpringWeb.models;

import javax.persistence.*;

import org.hibernate.annotations.Type;

@Entity
@Table(name = "administradores")
public class Administrador {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private int id;

  @Column(name = "nome", length = 100, nullable = false)
  private String nome;

  @Column(name = "email", length = 180, nullable = false)
  private String email;

  @Column(name = "senha", length = 255, nullable = false)
  private String senha;

  @Column(name = "observacao")
  @Type(type = "text")
  private String observacao;

  public String getObservacao() {
    return observacao;
  }

  public void setObservacao(String observacao) {
    this.observacao = observacao;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getSenha() {
    return this.senha;
  }

  public void setSenha(String senha) {
    this.senha = senha;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getNome() {
    return nome;
  }

  public void setNome(String nome) {
    this.nome = nome;
  }
}
