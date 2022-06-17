import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' hide showDialog, Colors;
import 'package:intl/intl.dart';

import 'package:eclinic/src/components/components.dart';

//   confirmado,
//   pago,
//   idTipo}

class ScreenAtendimento extends StatefulWidget {
  @override
  State<ScreenAtendimento> createState() => _ScreenAtendimentoState();
}

class _ScreenAtendimentoState extends State<ScreenAtendimento> {
  final edtData = TextEditingController();
  final edtPaciente = TextEditingController();
  final edtHoraInicio = TextEditingController();
  final edtHoraFim = TextEditingController();
  final edtDescricao = TextEditingController();
  final edtPreco = TextEditingController();
  final String? edtTipo = '';
  String tipo = 'Pessoal';
  var tipos = ['Pessoal', 'Ansiedade', 'Depressão'];

  @override
  Widget build(BuildContext context) {
    return (AlertDialog(
      title: Text('Agendamento'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: Column(
        children: <Widget>[
          TextFormField(
            controller: edtData,
            decoration: InputDecoration(
                icon: Icon(FluentIcons.calendar_agenda), //icon of text field
                labelText: "Data" //label text of field
                ),
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
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          SizedBox(height: 3),
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
          SizedBox(height: 3),
          TextField(
            controller: edtHoraInicio,
            decoration: InputDecoration(
                icon: Icon(FluentIcons.timer), labelText: 'Horario Inicial'),
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
                  edtHoraInicio.text =
                      "${pickedTime.hour}:${pickedTime.minute}";
                });
              } else {
                print("Time is not selected");
              }
            },
          ),
          SizedBox(height: 3),
          TextField(
            controller: edtHoraFim,
            decoration: InputDecoration(
                icon: Icon(FluentIcons.timer), labelText: 'Horario Final'),
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
                  edtHoraFim.text = "${pickedTime.hour}:${pickedTime.minute}";
                });
              } else {
                print("Time is not selected");
              }
            },
          ),
          SizedBox(height: 3),
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
          SizedBox(height: 3),
          TextFormField(
            controller: edtPreco,
            decoration: const InputDecoration(
              icon: Icon(FluentIcons.money),
              hintText: '',
              labelText: 'Preço da Consulta',
            ),
            validator: (String? value) {
              return (value == null) ? 'Campo obrigatório' : null;
            },
          ),
          SizedBox(height: 3),
          DropdownButton(
            value: tipo,
            icon: Icon(Icons.keyboard_arrow_down),
            items: tipos.map((String items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: null,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("CANCELAR")),
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, edtPaciente.text);
                  },
                  child: Text(
                    "CONFIRMAR",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    ));
  }
}
