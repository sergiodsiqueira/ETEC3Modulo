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
    return Expanded(
        child: Obx(
      () => ListView.builder(
        itemCount: _lista.todosAtendimentos.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(_lista.todosAtendimentos[index].id.toString()),
                  subtitle: Text(_lista.todosAtendimentos[index].descricao),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}

class BotaoConfirmado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Switch(value: true, onChanged: null));
  }
}
