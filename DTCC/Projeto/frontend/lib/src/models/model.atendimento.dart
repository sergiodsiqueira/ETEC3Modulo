import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Atendimento {
  int? id = 0;
  int? idPaciente = 0;
  DateTime? data = null;
  TimeOfDay? horaInicio = null;
  TimeOfDay? horaFim = null;
  String? descricao = '';
  String? observacao = '';
  bool? confirmado = false;
  bool? efetivado = false;
  double? valor = 0;
  bool? pago = false;
  int? idTipo = 0;

  Atendimento(
      {id,
      idPaciente,
      data,
      horaInicio,
      horaFim,
      descricao,
      observacao,
      confirmado,
      efetivado,
      valor,
      pago,
      idTipo});

  Atendimento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPaciente = json['id_paciente'];
    data = json['data'];
    horaInicio = json['hora_inicio'];
    horaFim = json['hora_fim'];
    descricao = json['descricao'];
    observacao = json['observacao'];
    confirmado = json['confirmado'];
    efetivado = json['efetivado'];
    valor = json['valor'];
    pago = json['pago'];
    idTipo = json['id_tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_paciente'] = this.idPaciente;
    data['data'] = this.data;
    data['hora_inicio'] = this.horaInicio;
    data['hora_fim'] = this.horaFim;
    data['descricao'] = this.descricao;
    data['observacao'] = this.observacao;
    data['confirmado'] = this.confirmado;
    data['efetivado'] = this.efetivado;
    data['valor'] = this.valor;
    data['pago'] = this.pago;
    data['id_tipo'] = this.idTipo;
    return data;
  }
}
