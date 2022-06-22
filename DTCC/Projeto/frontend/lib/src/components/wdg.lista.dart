import 'package:flutter/material.dart' hide Card, ListTile;
import 'package:fluent_ui/fluent_ui.dart' hide Colors, showDialog;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';

import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/components/components.dart';

class ListViewAtendimentos extends StatelessWidget {
  const ListViewAtendimentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Expanded(
        child: Column(children: [
      const Head(),
      Body(),
      const Footer(),
    ])));
  }
}

class Body extends StatelessWidget {
  final Atendimentos _lista = Get.find<Atendimentos>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(
      () => ListView.builder(
        itemCount: _lista.todosAtendimentos.length,
        itemBuilder: (context, index) {
          final atendimento = _lista.todosAtendimentos[index];
          return Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Card(
              backgroundColor: Colors.white,
              elevation: 2.0,
              child: Column(
                children: [
                  ListTile(
                    isThreeLine: true,
                    title: Text(
                        _lista.todosAtendimentos[index].descricao.toString()),
                    subtitle: Text(
                        _lista.todosAtendimentos[index].nome.toString() +
                            '\n' +
                            UtilData.obterHoraHHMM(DateTime(
                                0000,
                                00,
                                00,
                                _lista
                                    .todosAtendimentos[index].horaInicio!.hour,
                                _lista.todosAtendimentos[index].horaInicio!
                                    .minute)) +
                            ' - ' +
                            UtilData.obterHoraHHMM(DateTime(
                                0000,
                                00,
                                00,
                                _lista.todosAtendimentos[index].horaFim!.hour,
                                _lista
                                    .todosAtendimentos[index].horaFim!.minute)),
                        maxLines: 3),
                    leading: Container(
                        width: 5,
                        color: atendimento.confirmado == true
                            ? Colors.green
                            : Colors.red[400]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (atendimento.efetivado == true)
                          const WdgIconEfetivado(),
                        WdgEditarAtendimento(pAtendimento: atendimento),
                        WdgApagarAtendimento(pAtendimento: atendimento),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}

class Head extends StatelessWidget {
  const Head({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: SizedBox(
        height: 45,
        child: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: LblDataSelecionada(),
        ),
      ),
    );
  }
}

class LblDataSelecionada extends StatelessWidget {
  const LblDataSelecionada({Key? key}) : super(key: key);

  Atendimentos get _lista => Get.find<Atendimentos>();
  @override
  Widget build(BuildContext context) {
    return (Obx(() => Text(
          DateFormat("d ' de ' MMMM", "pt_BR")
              .format(DateTime.parse(_lista.dataSelecionada.value.toString())),
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w100,
              color: Colors.grey,
              wordSpacing: 0.5),
        )));
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: (ElevatedButton(
            child: Row(children: [Icon(Icons.add), Text('ADICIONAR')]),
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ScreenAgendamento());
            })),
      ),
    );
  }
}
