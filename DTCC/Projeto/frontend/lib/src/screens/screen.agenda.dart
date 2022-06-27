import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/components/components.dart';

class ScreenAgenda extends StatefulWidget {
  const ScreenAgenda({Key? key}) : super(key: key);

  @override
  State<ScreenAgenda> createState() => _TelaAgendaState();
}

class _TelaAgendaState extends State<ScreenAgenda> {
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
