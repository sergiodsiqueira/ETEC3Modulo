import 'package:flutter/material.dart' hide IconButton;
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/components/components.dart';

class ScreenAtendimento extends StatefulWidget {
  final Atendimento pAtendimento;
  final int pIdTipoAtendimento;

  const ScreenAtendimento(
      {Key? key, required this.pAtendimento, required this.pIdTipoAtendimento})
      : super(key: key);

  @override
  State<ScreenAtendimento> createState() => _ScreenAtendimentoState();
}

class _ScreenAtendimentoState extends State<ScreenAtendimento> {
  final Atendimentos _atendimentos = Get.find<Atendimentos>();
  late int Id = 0;
  late int IdPaciente = 0;
  final edtData = TextEditingController();
  final edtDescricao = TextEditingController();
  final edtHoraFim = TextEditingController();
  final edtHoraInicio = TextEditingController();
  final edtPaciente = TextEditingController();
  final edtTipo = TextEditingController();
  TipoAtendimento? comboBoxValueTipoAtendimento;
  DateTime? data;
  TimeOfDay? horaFim;
  TimeOfDay? horaInicio;

  @override
  void initState() {
    Id = widget.pAtendimento.id!;
    IdPaciente = widget.pAtendimento.idPaciente!;
    edtPaciente.text = widget.pAtendimento.idPaciente.toString();
    edtData.text = DateFormat('dd/MM/yyyy').format(widget.pAtendimento.data!);
    edtHoraInicio.text = widget.pAtendimento.horaInicio.toString();
    edtHoraFim.text = widget.pAtendimento.horaFim.toString();
    edtDescricao.text = widget.pAtendimento.descricao.toString();
    // comboBoxValueTipoAtendimento = TiposAtendimento.firstWhere(
    //     (tipos) => tipos.id == widget.pIdTipoAtendimento);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (AlertDialog(
      title: const Text('Atendimento'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: SizedBox(
        width: 700,
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WdgEdtData(myController: edtData),
                WdgEdtPaciente(myController: edtPaciente),
              ],
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
            const SizedBox(height: 10),
            WdgEdtTiposAtendimento(myController: edtTipo),
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
                      atendimento.id = Id;
                      atendimento.data = DateTime.parse(edtData.text);
                      atendimento.idPaciente = 0;
                      atendimento.horaInicio = horaInicio;
                      atendimento.horaFim = horaFim;
                      atendimento.descricao = edtDescricao.text;
                      atendimento.idTipo = comboBoxValueTipoAtendimento!.id;

                      print(
                          'Dados alterados:' + atendimento.toJson().toString());
                      // _atendimentos
                      //     .alterar(atendimento)
                      //     .then((value) => {Navigator.of(context).pop()});
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
