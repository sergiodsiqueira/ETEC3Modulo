import 'package:fluent_ui/fluent_ui.dart' hide Card, Colors;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/providers/providers.dart';
import 'package:intl/intl.dart';

final Atendimentos _atendimentos = Get.find<Atendimentos>();
final Pacientes _pacientes = Get.find<Pacientes>();

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(child: EstatisticasDiarias()),
        Container(child: EstatisticasResultadosFinanceiro()),
      ],
    ));
  }
}

//---------------------------------------------------------------- Cards Diarios
class EstatisticasDiarias extends StatelessWidget {
  const EstatisticasDiarias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: Wrap(children: [
        CardAtendimentos(),
        CardNaoConfirmados(),
        CardEfetivados(),
        CardPacientes()
      ]),
    ));
  }
}

class CardAtendimentos extends StatelessWidget {
  final DataAtual = DateTime.now().toIso8601String().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Colors.green[200],
                  width: 50,
                  height: 50,
                  child: Icon(
                    FluentIcons.calendar_day,
                    color: Colors.green[500],
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(
                      'Atendimentos',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(
                      DataAtual.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 8,
                          color: Color.fromARGB(255, 173, 174, 179),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Obx(
                      () => Text(
                        _atendimentos.atendimentosDoDia.value.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class CardNaoConfirmados extends StatelessWidget {
  final DataAtual = DateTime.now().toIso8601String().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Colors.yellow[200],
                  width: 50,
                  height: 50,
                  child: Icon(
                    FluentIcons.calendar_reply,
                    color: Colors.yellow,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(
                      'Confirmados',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(
                      DataAtual.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 8,
                          color: Color.fromARGB(255, 173, 174, 179),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Obx(
                      () => Text(
                        _atendimentos.confirmadosDia.value.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class CardEfetivados extends StatelessWidget {
  final DataAtual = DateTime.now().toIso8601String().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Color.fromARGB(153, 139, 184, 236),
                  width: 50,
                  height: 50,
                  child: Icon(FluentIcons.confirm_event, color: Colors.indigo),
                ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(
                      'Efetivados',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(
                      DataAtual.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 8,
                          color: Color.fromARGB(255, 173, 174, 179),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Obx(
                      () => Text(
                        _atendimentos.efetivadosDia.value.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class CardPacientes extends StatelessWidget {
  final DataAtual = DateTime.now().toIso8601String().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Color.fromARGB(153, 139, 184, 236),
                  width: 50,
                  height: 50,
                  child: Icon(FluentIcons.contact_list, color: Colors.indigo),
                ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(
                      'Pacientes',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Text(
                      'Total Geral de Pacientes',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 8,
                          color: Color.fromARGB(255, 173, 174, 179),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Obx(
                      () => Text(
                        _pacientes.todosPacientes.length.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
//----------------------------------------------------------- Grafico Financeiro

class EstatisticasResultadosFinanceiro extends StatelessWidget {
  const EstatisticasResultadosFinanceiro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      width: 700,
      height: 250,
      child: CardGrafico(),
    ));
  }
}

class CardGrafico extends StatelessWidget {
  const CardGrafico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (LineChartSample2());
  }
}

//-------------------------------------------------------- Graficos Atendimentos