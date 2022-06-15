import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/providers/providers.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Atendimentos _listaAtendimentos = Get.put(Atendimentos());

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
                        color: Color.fromARGB(26, 17, 133, 228),
                        child: LineChartSample2(),
                        width: 300,
                      ),
                      Container(
                        color: Color.fromARGB(26, 17, 133, 228),
                        child: BarChartSample2(),
                        width: 300,
                      ),
                      Container(
                        color: Color.fromARGB(26, 17, 133, 228),
                        child: PieChartSample2(),
                        width: 300,
                      ),
                      Container(
                        child: Column(children: [
                          const Text('Atendimentos'),
                          Obx(() => Text(_listaAtendimentos
                              .todosAtendimentos.length
                              .toString()))
                        ]),
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
