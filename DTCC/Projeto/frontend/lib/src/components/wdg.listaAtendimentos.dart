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
      Head(),
      Body(),
      Footer(),
    ])));
  }
}

class Body extends StatelessWidget {
  final Atendimentos _lista = Get.find<Atendimentos>();

  _apagar(BuildContext context, int pID) {
    print('vouapagar' + pID.toString());
    if (_lista.todosAtendimentos[pID].efetivado == true) {
      alert(context, 'Agendamento',
          'Não é possivel apagar visto que o atendimento já foi efetivado');
    } else {
      _lista.apagar(_lista.todosAtendimentos[pID].id!);
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
                      _lista.todosAtendimentos[index].descricao.toString() +
                          atendimento.id.toString()),
                  subtitle: Text(_lista.todosAtendimentos[index].id.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            _apagar(context, atendimento.id!);
                          },
                          icon: Icon(Icons.delete)),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: (Container(
        height: 50,
        child: LblDataSelecionada(),
      )),
    );
  }
}

class LblDataSelecionada extends StatelessWidget {
  final Atendimentos _lista = Get.find<Atendimentos>();

  @override
  Widget build(BuildContext context) {
    return (Obx(() => Text(_lista.dataSelecionada.value.toString())));
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: (ElevatedButton(
            child: Text('ADICIONAR'),
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ScreenAtendimento());
            })),
      ),
    );
  }
}
