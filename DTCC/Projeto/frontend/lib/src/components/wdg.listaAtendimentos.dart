import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/providers/providers.dart';

class ListViewAtendimentos extends StatefulWidget {
  @override
  State<ListViewAtendimentos> createState() => _ListViewAtendimentosState();
}

class _ListViewAtendimentosState extends State<ListViewAtendimentos> {
  @override
  Widget build(BuildContext context) {
    return (Expanded(child: Column(children: [Lista(), BotaoConfirmado()])));
  }
}

class Lista extends StatelessWidget {
  final Atendimentos _lista = Get.find<Atendimentos>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => (exibirLista(context, _lista.todosAtendimentos.length)));
  }

  exibirLista(context, var pQtdeAtendimentos) {
    if (pQtdeAtendimentos > 0) {
      return Obx(
        () => Column(children: [
          ListView.builder(
              itemCount: _lista.todosAtendimentos.length,
              // List item widget
              itemBuilder: (context, index) {
                final atendimento = _lista.todosAtendimentos[index];
                return Card(
                  key: ValueKey(atendimento.id),
                  margin: EdgeInsets.all(5),
                  color: Colors.amberAccent,
                  child: ListTile(
                      title: Text(atendimento.descricao),
                      subtitle: Text("\$${atendimento.horaInicio.toString()}"),
                      trailing: Obx(
                        () => IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.check_box_outline_blank),
                        ),
                      )),
                );
              })
        ]),
      );
    } else {
      return Column(children: [
        Icon(Icons.calendar_month_outlined),
        Text('Carregar atendimentos')
      ]);
    }
  }
}

class BotaoConfirmado extends StatelessWidget {
  const BotaoConfirmado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Switch(value: true, onChanged: null));
  }
}
