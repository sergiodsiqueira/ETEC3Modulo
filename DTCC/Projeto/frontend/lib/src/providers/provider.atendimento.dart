import 'package:eclinic/src/providers/provider.dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/components/components.dart';

final Login _login = Get.find<Login>();

class Atendimentos extends GetxController {
  final RxList<Atendimento> _todosAtendimentos = <Atendimento>[].obs;
  final RxString dataSelecionada =
      DateTime.now().toIso8601String().substring(0, 10).obs;
  final RxString x_access_token = ''.obs;
  late String feedback = '';
  late String _dados = '';

  late RxInt atendimentosDoDia = 0.obs;
  late RxInt efetivadosDia = 0.obs;
  late RxInt confirmadosDia = 0.obs;

  //Carga de dados por Data ----------------------------------------------------
  get carregarDados => () async {
        _todosAtendimentos.clear();

        if (x_access_token.value == '') {
          x_access_token.value = _login.x_access_token;
        }

        try {
          String url =
              "https://eclinic-teal.vercel.app/api/atendimentos/data?data='${dataSelecionada.value.substring(0, 10)}'";
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
              item.valor = double.parse(el['valor']);
              item.pago = el['pago'];
              item.idTipo = el['id_tipo'];
              item.nome = el['nome'];

              _todosAtendimentos.add(item);

              ContadorDiario();
            }
          } else {
            return ApiResponse.error("Erro ao carregar os atendimentos");
          }
        } catch (error) {
          return ApiResponse.error(
              "Servidor não responde... tente mais tarde...");
        }
      };

  List<Atendimento> get todosAtendimentos {
    return [..._todosAtendimentos];
  }

  // Adicionar Atendimento -----------------------------------------------------
  Future<void> adicionar(Atendimento pAtendimento) async {
    if (pAtendimento.id! > 0) {
      feedback = 'Impossivel incluir este atendimento';
      return;
    } else {
      gerarDados(pAtendimento);
    }

    final url = Uri.parse('https://eclinic-teal.vercel.app/api/atendimentos');
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

  // Alterar Atendimento -------------------------------------------------------
  Future<void> alterar(Atendimento pAtendimento) async {
    if (pAtendimento.id == 0) {
      feedback = 'Impossivel alterar este atendimento';
      return;
    } else {
      gerarDados(pAtendimento);
    }

    final url = Uri.parse(
        'https://eclinic-teal.vercel.app/api/atendimentos/${pAtendimento.id.toString()}');
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

  // Apagar Atendimento --------------------------------------------------------
  Future<void> apagar(int pID) async {
    final url = Uri.parse(
        'https://eclinic-teal.vercel.app/api/atendimentos/${pID.toString()}');
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

  // Gerar Dados para gravação -------------------------------------------------
  gerarDados(Atendimento pAtendimento) {
    try {
      _dados = '{"id_paciente": ${pAtendimento.idPaciente},';
      _dados +=
          '"data": "${pAtendimento.data!.toIso8601String().substring(0, 10)}",';
      _dados +=
          '"hora_inicio": "${pAtendimento.horaInicio!.hour.toString() + ':' + pAtendimento.horaInicio!.minute.toString()}",';
      _dados +=
          '"hora_fim": "${pAtendimento.horaFim!.hour.toString() + ':' + pAtendimento.horaFim!.minute.toString()}",';
      _dados += '"descricao": "${pAtendimento.descricao}",';
      _dados += '"observacao": "${pAtendimento.observacao}",';
      _dados += '"confirmado": ${pAtendimento.confirmado},';
      _dados += '"efetivado": ${pAtendimento.efetivado},';
      _dados += '"valor": ${pAtendimento.valor},';
      _dados += '"pago": ${pAtendimento.pago},';
      _dados += '"id_tipo": ${pAtendimento.idTipo}}';
    } catch (error) {
      errorPrint(error.toString(), 'provider.atendimento', 'Atendimento',
          'gerarDados');
    }
  }

  // Contador para quantidades usadas no Dashboard -----------------------------
  ContadorDiario() {
    if (dataSelecionada.value.toString().substring(0, 10) ==
        DateTime.now().toString().substring(0, 10)) {
      atendimentosDoDia.value = todosAtendimentos.length;

      efetivadosDia.value =
          _todosAtendimentos.where((item) => item.efetivado == true).length;

      confirmadosDia.value =
          _todosAtendimentos.where((item) => item.confirmado == true).length;
    }
  }
}
