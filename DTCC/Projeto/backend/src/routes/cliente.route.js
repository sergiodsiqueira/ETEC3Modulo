const router = require("express-promise-router")();
const usuarioController = require("../controllers/cliente.controller");
const rule = require("../config/jwt");

router.post("/clientes", rule.JWT, usuarioController.adicionar);
router.get("/clientes", rule.JWT, usuarioController.listarTodos);
router.get("/clientes/:id", rule.JWT, usuarioController.listarUnico);
router.put("/clientes/:id", rule.JWT, usuarioController.atualizar);

module.exports = router;
