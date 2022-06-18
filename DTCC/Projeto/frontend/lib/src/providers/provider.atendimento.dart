import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/components/components.dart';
import 'package:intl/intl.dart';

class Atendimentos extends GetxController {
  final Login _login = Get.find<Login>();
  final RxList<Atendimento> _todosAtendimentos = <Atendimento>[].obs;
  final RxString dataSelecionada =
      DateTime.now().toIso8601String().substring(0, 10).obs;
  final RxString x_access_token = ''.obs;
  late String feedback = '';
  late String _dados = '';

  //Carga de dados
  get carregarDados => () async {
        _todosAtendimentos.clear();

        if (x_access_token.value == '') {
          x_access_token.value = _login.x_access_token;
        }

        try {
          String url =
              "https://app-eclinic-oficinadamente.herokuapp.com/api/atendimentos/data?data='${dataSelecionada.value.substring(0, 10)}'";
          var response = await http.get(Uri.parse(url), headers: {
            "Content-Type": "application/json",
            'x-access-token': x_access_token.value
          });

          if (response.statusCode == 200) {
            var dados = json.decode(response.body);
            for (var el in dados) {
              String hora = '';
              String minuto = '';

              Atendimento item = Atendimento();
              item.id = el['id'];
              item.idPaciente = el['id_paciente'];
              item.data = DateTime.parse(el['data']);
              hora = el['hora_inicio'].toString().substring(0, 2);
              minuto = el['hora_inicio'].toString().substring(3, 5);
              item.horaInicio =
                  TimeOfDay(hour: int.parse(hora), minute: int.parse(minuto));
              hora = el['hora_fim'].toString().substring(0, 2);
              minuto = el['hora_fim'].toString().substring(3, 5);

              item.horaFim =
                  TimeOfDay(hour: int.parse(hora), minute: int.parse(minuto));
              item.descricao = el['descricao'];
              item.observacao = el['observacao'];
              item.confirmado = el['confirmado'];
              item.efetivado = el['efetivado'];
              //item.valor = double.parse(el['valor'].toString());
              item.pago = el['pago'];
              item.idTipo = el['id_tipo'];

              _todosAtendimentos.add(item);
            }

            for (var e in _todosAtendimentos) {
              print(e.id.toString());
            }
          } else {
            return ApiResponse.error("Erro ao carregar atendimentos");
          }
        } catch (error, exception) {
          return ApiResponse.error("Sem comunica��o ... tente mais tarde... ");
        }
      };

  //Lista de todos Atendimentos
  List<Atendimento> get todosAtendimentos {
    return [..._todosAtendimentos];
  }

  //Lista de atendimentos efetivados
  List<Atendimento> get efetivados {
    return _todosAtendimentos.where((x) => x.efetivado == true).toList();
  }

  //Adicionar ao efetivados
  // void efetivar(int id) {
  //   final int index = _todosAtendimentos.indexWhere((x) => x.id == id);
  //   _todosAtendimentos[index].efetivado = true;
  // }

  Future<void> adicionar(Atendimento pAtendimento) async {
    if (pAtendimento.id! > 0) {
      feedback = 'Impossivel incluir este atendimento';
      return;
    } else {
      gerarDados(pAtendimento);
    }

    final url = Uri.parse(
        'https://app-eclinic-oficinadamente.herokuapp.com/api/atendimentos');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'x-access-token': x_access_token.value,
        },
        body: _dados);
    if (response.statusCode >= 400) {
      feedback = response.body;
    } else {
      feedback = response.body;
      carregarDados();
    }
  }

  Future<void> alterar(Atendimento pAtendimento) async {
    if (pAtendimento.id == 0) {
      feedback = 'Impossivel alterar este atendimento';
      return;
    } else {
      gerarDados(pAtendimento);
    }

    final url = Uri.parse(
        'https://app-eclinic-oficinadamente.herokuapp.com/api/atendimentos');
    final response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          'x-access-token': x_access_token.value,
        },
        body: _dados);
    if (response.statusCode >= 400) {
      feedback = response.body;
    } else {
      feedback = response.body;
      carregarDados();
    }
  }

  Future<void> apagar(int pID) async {
    final url = Uri.parse(
        'https://app-eclinic-oficinadamente.herokuapp.com/api/atendimentos/' +
            pID.toString());
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        'x-access-token': x_access_token.value,
      },
    );
    if (response.statusCode >= 400) {
      feedback = response.body;
    } else {
      feedback = response.body;
      carregarDados();
    }
  }

  gerarDados(Atendimento pAtendimento) {
    _dados = '';
    _dados += '{"id_paciente": ${pAtendimento.id},';
    _dados +=
        '"data": "${pAtendimento.data!.toIso8601String().substring(0, 10)}",';
    _dados +=
        '"hora_inicio": "${pAtendimento.horaFim!.hour.toString() + ':' + pAtendimento.horaFim!.minute.toString()}",';
    _dados +=
        '"hora_fim": "${pAtendimento.horaFim!.hour.toString() + ':' + pAtendimento.horaFim!.minute.toString()}",';
    _dados += '"descricao": "${pAtendimento.descricao}",';
    _dados += '"observacao": "${pAtendimento.observacao}",';
    _dados += '"confirmado": ${pAtendimento.confirmado},';
    _dados += '"efetivado": ${pAtendimento.efetivado},';
    _dados += '"valor": ${pAtendimento.valor.toString()},';
    _dados += '"pago": ${pAtendimento.pago},';
    _dados += '"id_tipo": ${pAtendimento.idTipo}';
    _dados += '}';
  }
}
