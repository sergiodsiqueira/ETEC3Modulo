import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/models/models.dart';

class ListViewAtendimentos extends StatelessWidget {
  const ListViewAtendimentos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Expanded(
        child: Container(
      child: Column(children: [
        Head(),
        Body(),
        Footer(),
      ]),
    )));
  }
}

class Body extends StatelessWidget {
  final Atendimentos _lista = Get.find<Atendimentos>();

  _apagar(BuildContext context, Atendimento pAtendimento) {
    if (pAtendimento.efetivado == true) {
      alert(context, 'Agendamento',
          'Não é possivel apagar visto que o atendimento já foi efetivado');
    } else {
      _lista.apagar(pAtendimento.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(
      () => ListView.builder(
        itemCount: _lista.todosAtendimentos.length,
        itemBuilder: (context, index) {
          final atendimento = _lista.todosAtendimentos[index];
          return Card(
            elevation: 2.0,
            child: Column(
              children: [
                ListTile(
                  key: Key(_lista.todosAtendimentos[index].id.toString()),
                  title: Text(
                      _lista.todosAtendimentos[index].descricao.toString()),
                  subtitle:
                      Text(_lista.todosAtendimentos[index].nome.toString()),
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
                      WdgEditarAtendimento(atendimento: atendimento),
                      WdgApagarAtendimento(),
                    ],
                  ),
                ),
              ],
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
