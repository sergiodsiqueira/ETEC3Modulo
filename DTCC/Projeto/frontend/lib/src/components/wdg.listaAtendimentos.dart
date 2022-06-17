import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/components/components.dart';

class ListViewAtendimentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Expanded(
        child: Column(children: [
      Cabecalho(),
      Lista(),
    ])));
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
                  subtitle: Text('Evento' + index.toString()),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}

class Cabecalho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: (Wrap(
        children: [
          LblDataSelecionada(),
          BtnAdicionar(),
        ],
      )),
    );
  }
}

class LblDataSelecionada extends StatelessWidget {
  final Atendimentos _lista = Get.find<Atendimentos>();

  DataBR(String pData) {
    try {
      if (pData != '') {
        return pData;
      } else {
        return 'Impossivel converter a data';
      }
    } catch (error) {
      Get.snackbar('Erro', 'Data inv�lida');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Obx(() => Text(DataBR(_lista.dataSelecionada.value.toString()))));
  }
}

class BtnAdicionar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (ElevatedButton(
      child: Text('ADICIONAR'),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => ScreenAtendimento()).then((value) {
          if (value != null) {
            print(value);
          }
        });
      },
    ));
  }
}
