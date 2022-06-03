import 'package:flutter/material.dart';
import '../../components/components.dart';

class TelaAgenda extends StatefulWidget {
  const TelaAgenda({Key? key}) : super(key: key);

  @override
  State<TelaAgenda> createState() => _TelaAgendaState();
}

class _TelaAgendaState extends State<TelaAgenda> {
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
                        child: wdgCalendario(),
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: MediaQuery.of(context).size.height - 100,
                      ),
                      Container(
                        child: wdgAgendamentos(),
                        width: MediaQuery.of(context).size.width / 2.9,
                        height: MediaQuery.of(context).size.height - 100,
                      ),
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
