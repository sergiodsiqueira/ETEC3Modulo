const db = require("../config/database");

exports.adicionar = async (req, res) => {
  const { login, senha, tipo, id_cliente } = req.body;

  const { rows } = await db.query(
    "INSERT INTO usuarios (login, senha, tipo, id_cliente) VALUES ($1, $2, $3, $4)",
    [login, senha, tipo, id_cliente]
  );

  res.status(201).send("Usuário adicionado com sucesso");
};

exports.listarTodos = async (req, res) => {
  const response = await db.query(
    "SELECT id, login, tipo, id_cliente FROM usuarios ORDER BY id ASC"
  );
  res.status(200).send(response.rows);
};

exports.listarUnico = async (req, res) => {
  const id = parseInt(req.params.id);
  const response = await db.query(
    "SELECT id, login, tipo, id_cliente FROM usuarios WHERE id = $1",
    [id]
  );
  res.status(200).send(response.rows);
};

exports.atualizar = async (req, res) => {
  const id = parseInt(req.params.id);
  const { login, id_cliente } = req.body;

  const response = await db.query(
    "UPDATE usuarios SET login = $1, id_cliente = $2 WHERE id = $3",
    [login, id_cliente, id]
  );

  res.status(200).send("Usuário atualizado com sucesso");
};
