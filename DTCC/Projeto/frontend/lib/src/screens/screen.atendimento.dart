import 'package:flutter/material.dart' hide IconButton;
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/models/models.dart';

class ScreenAtendimento extends StatefulWidget {
  @override
  State<ScreenAtendimento> createState() => _ScreenAtendimentoState();
}

class _ScreenAtendimentoState extends State<ScreenAtendimento> {
  final Atendimentos _atendimentos = Get.find<Atendimentos>();
  final edtData = TextEditingController();
  DateTime? data;
  final edtPaciente = TextEditingController();
  final edtHoraInicio = TextEditingController();
  TimeOfDay? horaInicio;
  final edtHoraFim = TextEditingController();
  TimeOfDay? horaFim;
  final edtDescricao = TextEditingController();
  final String? edtTipo = '';

  static const _tiposAtendimentos = <String>[
    'Pessoal',
    'Ansiedade',
    'Depressão',
    'Famíliar',
    'Financeiro'
  ];
  String? comboBoxValue;

  @override
  Widget build(BuildContext context) {
    return (AlertDialog(
      title: const Text('Agendamento'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: Container(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: edtData,
              decoration: const InputDecoration(
                  icon: Icon(FluentIcons.calendar_agenda), labelText: "Data"),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  setState(() {
                    edtData.text = formattedDate;
                    data = pickedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
            const SizedBox(height: 3),
            TextFormField(
              controller: edtPaciente,
              decoration: const InputDecoration(
                icon: Icon(FluentIcons.contact),
                hintText: '',
                labelText: 'Paciente',
              ),
              validator: (String? value) {
                return (value == null) ? 'Campo obrigatório' : null;
              },
            ),
            const SizedBox(height: 3),
            TextField(
              controller: edtHoraInicio,
              decoration: const InputDecoration(
                  icon: Icon(FluentIcons.timer), labelText: 'Horário Inicial'),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                    initialEntryMode: TimePickerEntryMode.input,
                    initialTime: TimeOfDay.now(),
                    context: context,
                    builder: (context, childWidget) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: childWidget!);
                    });

                if (pickedTime != null) {
                  horaInicio = pickedTime;
                  setState(() {
                    String pHora = "${pickedTime.hour}:${pickedTime.minute}";
                    if (pHora.split(':').last.toString() == '0') {
                      pHora += '0';
                    }
                    edtHoraInicio.text = pHora;
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            const SizedBox(height: 3),
            TextField(
              controller: edtHoraFim,
              decoration: const InputDecoration(
                  icon: Icon(FluentIcons.timer), labelText: 'Horário Final'),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                    initialEntryMode: TimePickerEntryMode.input,
                    initialTime: TimeOfDay.now(),
                    context: context,
                    builder: (context, childWidget) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: childWidget!);
                    });

                if (pickedTime != null) {
                  setState(() {
                    horaFim = pickedTime;
                    String pHora = "${pickedTime.hour}:${pickedTime.minute}";
                    if (pHora.split(':').last.toString() == '0') {
                      pHora += '0';
                    }
                    edtHoraFim.text = pHora;
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            const SizedBox(height: 3),
            TextFormField(
              controller: edtDescricao,
              decoration: const InputDecoration(
                icon: Icon(FluentIcons.event_info),
                hintText: '',
                labelText: 'Descrição',
              ),
              validator: (String? value) {
                return (value == null) ? 'Campo obrigatório' : null;
              },
            ),
            const SizedBox(height: 3),
////// Combobox
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("CANCELAR")),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () {
                      Atendimento atendimento = Atendimento();
                      atendimento.data = data;
                      atendimento.idPaciente = 0;
                      atendimento.horaInicio = horaInicio;
                      atendimento.horaFim = horaFim;
                      atendimento.descricao = edtDescricao.text;
                      atendimento.idTipo = 0;

                      _atendimentos
                          .adicionar(atendimento)
                          .then((value) => {Navigator.of(context).pop()});
                    },
                    child: const Text(
                      "CONFIRMAR",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
