const express = require("express");
const bodyParser = require("body-parser");
const app = express();

const port = process.env.PORT || 8080;

var dataHora = new Date();

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.use(express.json());

app.get("/", (req, res) =>
  res.json({ info: "Bem-vindo a API e-Clinic " + dataHora })
);

app.listen(port, () => console.log(`API e-Clinic escutando a porta:${port}`));
