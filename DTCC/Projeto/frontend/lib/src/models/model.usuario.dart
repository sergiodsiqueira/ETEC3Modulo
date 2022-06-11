//https://app-eclinic-oficinadamente.herokuapp.com/api/usuarios
import 'package:flutter/material.dart';

class Usuario {
  late int id;
  late String login;
  late String senha;
  late String tipo;
  late int id_cliente;

  Usuario({
    required this.id,
    required this.login,
    required this.senha,
    required this.tipo,
    required this.id_cliente,
  });
}
