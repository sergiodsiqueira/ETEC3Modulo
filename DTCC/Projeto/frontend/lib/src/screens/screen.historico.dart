import 'package:flutter/material.dart' hide Scrollbar, IconButton;
import 'package:fluent_ui/fluent_ui.dart' hide Colors, Card, ListTile;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';

import 'package:eclinic/src/models/models.dart';

final Login login = Get.find<Login>();

class ScreenHistorico extends StatefulWidget {
  final Paciente? paciente;
  const ScreenHistorico({Key? key, required this.paciente}) : super(key: key);

  @override
  State<ScreenHistorico> createState() => _ScreenHistoricoState();
}

class _ScreenHistoricoState extends State<ScreenHistorico> {
  List<Atendimento> listaAtendimentos = [];
  List<Atendimento> listaFiltrada = [];

  bool filtraEfetivados = false;
  bool filtraPagos = false;
  bool filtrarNaoPagos = false;
  bool filtrarNaoEfetivados = false;

  carregarAtendimentos() {
    API.carregarAtendimentos(widget.paciente!.id!).then((res) {
      setState(() {
        if ((res as http.Response).statusCode < 400) {
          var dados = json.decode(res.body);
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

            listaAtendimentos.add(item);
          }
        }
      });
    });
  }

  filtrar() {
    List<Atendimento> resultado = [];
    if (filtraEfetivados) {
      resultado = listaAtendimentos.where((e) => e.efetivado == true).toList();
    } else if (filtraPagos) {
      resultado = listaAtendimentos.where((e) => e.pago == true).toList();
    } else if (filtrarNaoEfetivados) {
      resultado = listaAtendimentos.where((e) => e.efetivado == false).toList();
    } else if (filtrarNaoPagos) {
      resultado = listaAtendimentos.where((e) => e.pago == false).toList();
    } else {
      resultado = listaAtendimentos;
    }

    setState(() {
      listaFiltrada = resultado;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarAtendimentos();
    filtrar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Text(
            'Histórico de Consultas',
            style: TextStyle(
                color: Color.fromARGB(226, 158, 158, 158), fontSize: 18),
          ),
          const SizedBox(height: 10),
          listaAtendimentos.isEmpty
              ? const Text(
                  'Paciente sem atendimentos',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listaFiltrada.length,
                    itemBuilder: (context, index) {
                      final atendimento = listaFiltrada[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Card(
                          elevation: 2.0,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(atendimento.descricao.toString()),
                                subtitle: Text(UtilData.obterDataDDMMAAAA(
                                    atendimento.data!)),
                                trailing: (Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (atendimento.efetivado == true)
                                        const Icon(
                                            FluentIcons.skype_circle_check),
                                      const SizedBox(width: 5),
                                      if (atendimento.pago == true)
                                        const Icon(FluentIcons.circle_dollar),
                                    ])),
                              ),
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, bottom: 5),
                                  child: Text('Anotações',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 15),
                                alignment: Alignment.centerLeft,
                                child: atendimento.observacao!.isEmpty
                                    ? const Text('Sem observações',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 9))
                                    : Text(atendimento.observacao.toString()),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          const SizedBox(height: 20),
          if (!listaAtendimentos.isEmpty)
            Row(
              children: [
                InfoLabel(
                  label: 'Efetivados',
                  child: Switch(
                    value: filtraEfetivados,
                    onChanged: (value) {
                      setState(() {
                        filtraEfetivados = value;
                        filtraPagos = false;
                        filtrarNaoPagos = false;
                        filtrarNaoEfetivados = false;
                        filtrar();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 30),
                InfoLabel(
                  label: 'Pagos',
                  child: Switch(
                    value: filtraPagos,
                    onChanged: (value) {
                      setState(() {
                        filtraEfetivados = false;
                        filtraPagos = value;
                        filtrarNaoPagos = false;
                        filtrarNaoEfetivados = false;
                        filtrar();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 30),
                InfoLabel(
                  label: 'Não Pagos',
                  child: Switch(
                    value: filtrarNaoPagos,
                    onChanged: (value) {
                      setState(() {
                        filtraEfetivados = false;
                        filtraPagos = false;
                        filtrarNaoPagos = value;
                        filtrarNaoEfetivados = false;
                        filtrar();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 30),
                InfoLabel(
                  label: 'Não Efetivados',
                  child: Switch(
                    value: filtrarNaoEfetivados,
                    onChanged: (value) {
                      setState(() {
                        filtraEfetivados = false;
                        filtraPagos = false;
                        filtrarNaoPagos = false;
                        filtrarNaoEfetivados = value;
                        filtrar();
                      });
                    },
                  ),
                ),
              ],
            )
        ],
      ),
    ));
  }
}

class API {
  static Future carregarAtendimentos(int ID) async {
    var url =
        'https://eclinic-teal.vercel.app/api/atendimentos/paciente?id=${ID.toString()}';

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      'x-access-token': login.x_access_token
    });

    return response;
  }
}
