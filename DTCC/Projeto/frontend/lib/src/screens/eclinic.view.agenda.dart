import 'package:flutter/material.dart';
import '../../components/components.dart';
import '../states/eclinic.state.agenda.dart';
import 'package:get/get.dart';

class TelaAgenda extends StatefulWidget {
  const TelaAgenda({Key? key}) : super(key: key);

  @override
  State<TelaAgenda> createState() => _TelaAgendaState();
}

class _TelaAgendaState extends State<TelaAgenda> {
  final Agendamentos _agendamentos = Get.put(Agendamentos());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        transformAlignment: Alignment.topCenter,
                        child: Calendar(),
                        width: 300,
                        height: 400,
                      ),
                      Container(
                          color: Colors.blue,
                          child: ListView.builder(
                            itemCount: _agendamentos.items.length,
                            itemBuilder: (context, index) {
                              final evento = _agendamentos.items[index];
                              return Card(
                                key: ValueKey(evento.id),
                                margin: EdgeInsets.all(5),
                                color: Colors.amber,
                                child: ListTile(title: Text(evento.evento)),
                              );
                            },
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
