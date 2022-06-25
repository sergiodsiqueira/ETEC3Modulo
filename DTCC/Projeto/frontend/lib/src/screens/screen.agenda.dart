import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/components/components.dart';

class TelaAgenda extends StatefulWidget {
  const TelaAgenda({Key? key}) : super(key: key);

  @override
  State<TelaAgenda> createState() => _TelaAgendaState();
}

class _TelaAgendaState extends State<TelaAgenda> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Wrap(
          children: [
            Container(
              child: Calendario(),
              width: MediaQuery.of(context).size.width / 1.7,
              height: MediaQuery.of(context).size.height - 100,
            ),
            Container(
              child: ListViewAtendimentos(),
              width: MediaQuery.of(context).size.width / 2.9,
              height: MediaQuery.of(context).size.height - 100,
            ),
          ],
        ),
      ),
    );
  }
}
