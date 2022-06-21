import 'package:eclinic/src/components/wdg.utils.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/models/models.dart';

class ScreenAgendamento extends StatefulWidget {
  const ScreenAgendamento({Key? key}) : super(key: key);

  @override
  State<ScreenAgendamento> createState() => _ScreenAgendamentoState();
}

class _ScreenAgendamentoState extends State<ScreenAgendamento> {
  final Atendimentos _atendimentos = Get.find<Atendimentos>();

  DateTime? data;
  final edtData = TextEditingController();
  final edtDescricao = TextEditingController();
  final edtHoraFim = TextEditingController();
  final edtHoraInicio = TextEditingController();
  final edtPaciente = TextEditingController();
  final edtTipo = TextEditingController();
  TimeOfDay? horaFim;
  TimeOfDay? horaInicio;
  TipoAtendimento? comboBoxValueTipoAtendimento;

  @override
  Widget build(BuildContext context) {
    return (AlertDialog(
      title: const Text('Agendamento'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            WdgEdtData(myController: edtData),
            WdgEdtPaciente(myController: edtPaciente),
            Row(
              children: [
                WdgEdtHora(
                    myController: edtHoraInicio, label: 'Horário Inicial'),
                const SizedBox(width: 30),
                WdgEdtHora(myController: edtHoraFim, label: 'Horário Final'),
              ],
            ),
            WdgEdtSimples(
                myController: edtDescricao,
                label: 'Descrição',
                placehold: 'Informe a descrição do agendamento'),
            WdgEdtTiposAtendimento(myController: edtTipo),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("CANCELAR")),
                const SizedBox(width: 30),
                ElevatedButton(
                    onPressed: () {
                      Atendimento atendimento = Atendimento();
                      atendimento.data =
                          DateFormat('dd/MM/yyyy').parse(edtData.text);
                      atendimento.idPaciente = 0;
                      atendimento.horaInicio =
                          parseTimeOfDay(edtHoraInicio.text.toString());
                      atendimento.horaFim =
                          parseTimeOfDay(edtHoraFim.text.toString());
                      atendimento.descricao = edtDescricao.text;
                      var tipoAtendimento = TiposAtendimento.firstWhere(
                          (e) => e.descricao == edtTipo.text);
                      atendimento.idTipo = tipoAtendimento.id;

                      print(atendimento.toJson().toString());
                      // _atendimentos
                      //     .adicionar(atendimento)
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
