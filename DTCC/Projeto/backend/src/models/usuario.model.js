const db = require("../config/database");

module.exports = class Usuario {
  constructor() {
    this._id;
    this._login;
    this._senha;
    this._tipo;
    this._id_cliente;
  }

  get id() {
    return this._id;
  }
  set id(value) {
    if (id <= 0 || id == null) {
      throw "Id inválido";
    }
    this._id = value;
  }

  get login() {
    return this._login;
  }
  set login(value) {
    if (value == "") {
      throw "Login inválido";
    }

    if (validaEmail(value)) {
      throw "Login não é um e-mail válido";
    }

    this._login = value;
  }

  get senha() {
    return this._senha;
  }
  set senha(value) {
    if (value == "" || value == null) {
      return "Senha em branco";
    }
    if (value.length <= 7) {
      throw "Senha menor que 8 caracteres";
    }
    this._senha = value;
  }

  get tipo() {
    return this._tipo;
  }
  set tipo(value) {
    if (!(value in ["A", "U"])) {
      return "Tipo inválido";
    }

    this._tipo = value;
  }

  obter(value) {
    //
  }

  gravar() {
    //
  }

  apagar(value) {
    //
  }
};

function validaEmail(email) {
  var re = /\S+@\S+\.\S+/;
  return re.test(email);
}
