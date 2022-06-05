const db = require("../config/database");

exports.adicionar = async (req, res) => {
  const { nome, email } = req.body;

  const { rows } = await db.query(
    "INSERT INTO clientes (nome, email) VALUES ($1, $2)",
    [nome, email]
  );

  res.status(201).send("Cliente adicionado com sucesso");
};

exports.listarTodos = async (req, res) => {
  const response = await db.query("SELECT * FROM clientes ORDER BY id ASC");
  res.status(200).send(response.rows);
};

exports.listarUnico = async (req, res) => {
  const id = parseInt(req.params.id);
  const response = await db.query("SELECT * FROM clientes WHERE id = $1", [id]);
  res.status(200).send(response.rows);
};

exports.atualizar = async (req, res) => {
  const id = parseInt(req.params.id);
  const { nome, email } = req.body;

  const response = await db.query(
    "UPDATE clientes SET nome = $1, email = $2 WHERE id = $3",
    [nome, email, id]
  );

  res.status(200).send("Cliente atualizado com sucesso");
};
