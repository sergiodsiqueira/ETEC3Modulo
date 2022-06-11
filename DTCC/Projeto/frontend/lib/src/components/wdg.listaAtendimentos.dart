import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eclinic/src/models/model.login.dart';

class ListViewAtendimentos extends StatefulWidget {
  final Login _login = Get.put(Login());

  @override
  State<ListViewAtendimentos> createState() => _ListViewAtendimentosState();
}

class _ListViewAtendimentosState extends State<ListViewAtendimentos> {
  @override
  Widget build(BuildContext context) {
    return (Text('Ola')
        // ListView.builder(
        //   itemCount: listaAgendamentos.length,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       child: Padding(
        //         padding: EdgeInsets.all(10),
        //         child: ListTile(
        //           title: Text(
        //             listaAgendamentos[index].evento,
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ),
        //           leading: CircleAvatar(
        //             child: Text(
        //               listaAgendamentos[index].evento[0],
        //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //           trailing: Text(
        //               "\$ ${listaAgendamentos[index].horaInicial.toString()}"),
        //         ),
        //       ),
        //     );
        //   })
        );
  }
}
