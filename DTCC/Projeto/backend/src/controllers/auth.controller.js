const db = require("../config/database");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const { rows } = require("pg/lib/defaults");

/*Login*/
const login = async (req, res) => {
  const { login, senha } = req.body;
  const user = await db.query("SELECT id FROM usuarios WHERE login = $1 AND senha = $2", [
    login,
    senha,
  ]).then((r) => {
    if (r.rowCount > 0) {
      const token = jwt.sign(r.rows[0], process.env.JWT_TOKEN, { expiresIn: '1h' });
      res.status(200).json({ 'x-access-token': token })
    } else {
      res.status(401).json({ message: 'Unauthorized' })
    }
  }).catch((err) => { res.status(500).json({ error: 'Internal error' }) });
};

/*Logout*/
const logout = (req, res) => {
  res.json({ auth: false, token: null });
};

module.exports = { login, logout };
