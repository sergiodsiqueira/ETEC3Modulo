import 'package:flutter/material.dart'
    hide ListTile, Card, Scrollbar, IconButton;
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/models/models.dart';

class ScreenPacientes extends StatefulWidget {
  final Paciente? paciente;
  const ScreenPacientes({Key? key, this.paciente}) : super(key: key);

  @override
  State<ScreenPacientes> createState() => _ScreenPacientesState();
}

class _ScreenPacientesState extends State<ScreenPacientes> {
  final Pacientes _pacientes = Get.find<Pacientes>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Obx(
          () => Scrollbar(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _pacientes.todosPacientes.length,
                itemBuilder: (context, index) {
                  final paciente = _pacientes.todosPacientes[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Card(
                      backgroundColor: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(_pacientes.todosPacientes[index].nome
                                .toString()),
                            subtitle: Text(_pacientes
                                .todosPacientes[index].email
                                .toString()),
                            leading: const Icon(FluentIcons.contact),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(FluentIcons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScreenEditaPaciente(
                                                  paciente: paciente)),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    ));
  }
}
