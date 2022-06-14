import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/providers/providers.dart';

class ListViewAtendimentos extends StatefulWidget {
  @override
  State<ListViewAtendimentos> createState() => _ListViewAtendimentosState();
}

class _ListViewAtendimentosState extends State<ListViewAtendimentos> {
  final Atendimentos _todosAtendimentos = Get.find<Atendimentos>();
  @override
  Widget build(BuildContext context) {
    return (Column(children: [Text('Ola mundo'),
                              ElevatedButton(onPressed: () => {_todosAtendimentos.carregarDados()}, child: Icon(Icons.cloud_download)),
                              Obx(() => Text(_todosAtendimentos.todosAtendimentos.length.toString())),
            
        Expanded(
          child: ListView.builder(
            itemCount: _todosAtendimentos.todosAtendimentos.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      _todosAtendimentos.todosAtendimentos[index].descricao,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        _todosAtendimentos.todosAtendimentos[index].descricao[0],
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: Text(
                        "\$ ${_todosAtendimentos.todosAtendimentos[index].horaInicio.toString()}"),
                  ),
                ),
              );
            }),
        )
  ]));}
}
