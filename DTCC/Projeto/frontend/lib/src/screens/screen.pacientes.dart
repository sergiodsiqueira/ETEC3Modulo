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
  List<Paciente> _pacientesFiltrados = [];

  @override
  void initState() {
    _pacientesFiltrados = _pacientes.todosPacientes;
    super.initState();
  }

  void _filtrar(String pesquisa) {
    List<Paciente> filtrado = [];
    if (pesquisa.isEmpty) {
      filtrado = _pacientes.todosPacientes;
    } else {
      filtrado = _pacientes.todosPacientes
          .where((paciente) => paciente.nome
              .toString()
              .toLowerCase()
              .contains(pesquisa.toLowerCase()))
          .toList();
    }

    setState(() {
      _pacientesFiltrados = filtrado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(15),
      child:
          // Obx(
          //   () =>
          Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 400,
                  child: TextField(
                    onChanged: (value) => _filtrar(value),
                    decoration: const InputDecoration(
                        labelText: 'Pesquisar',
                        suffixIcon: Icon(FluentIcons.search)),
                  ),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                    mini: true,
                    child: const Icon(FluentIcons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenEditaPaciente()),
                      );
                    }),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _pacientesFiltrados.length,
              itemBuilder: (context, index) {
                final paciente = _pacientesFiltrados[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Card(
                    backgroundColor: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: [
                        ListTile(
                          title:
                              Text(_pacientesFiltrados[index].nome.toString()),
                          subtitle:
                              Text(_pacientesFiltrados[index].email.toString()),
                          leading: const Icon(FluentIcons.contact),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(FluentIcons.edit),
                                onPressed: () {
                                  if (paciente.id == 0) {
                                    showMessage(context, 'Paciente Especial',
                                        'Atenção! Paciente exclusivo para uso interno.');
                                    return;
                                  }
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
        ],
      ),
      //)
    ));
  }
}
