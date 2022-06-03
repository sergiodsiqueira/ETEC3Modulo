import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Agendamento {
  int id;
  String evento;
  String observacao;
  DateTime data;
  DateTime horaInicial;
  DateTime horaFinal;
  RxBool confirmado; //Variavel a ser observada
  int idTipoEvento;
  String descricaoTipoEvento;
  int idPaciente;
  String nomePaciente;

  Agendamento({
    required this.id,
    required this.evento,
    required this.observacao,
    required this.data,
    required this.horaInicial,
    required this.horaFinal,
    required this.confirmado,
    required this.idTipoEvento,
    required this.descricaoTipoEvento,
    required this.idPaciente,
    required this.nomePaciente,
  });
}
