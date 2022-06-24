import 'package:flutter/material.dart' hide IconButton;
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/components/wdg.utils.dart';
import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/models/models.dart';

class ScreenAgendamento extends StatefulWidget {
  const ScreenAgendamento({Key? key}) : super(key: key);

  @override
  State<ScreenAgendamento> createState() => _ScreenAgendamentoState();
}

class _ScreenAgendamentoState extends State<ScreenAgendamento> {
  final Atendimentos _atendimentos = Get.find<Atendimentos>();
  final Pacientes _pacientes = Get.find<Pacientes>();

  DateTime? data;
  final edtData = TextEditingController();
  final edtDescricao = TextEditingController();
  final edtHoraFim = TextEditingController();
  final edtHoraInicio = TextEditingController();
  final edtPaciente = TextEditingController();
  final edtTipo = TextEditingController();

  _gravar() {
    Atendimento atendimento = Atendimento();
    int? idTipo;
    TipoAtendimento? tipo;
    int? idPaciente;
    Paciente? paciente;
    DateTime horaIni;
    DateTime horaFim;

    if (edtData.text.isEmpty && !edtData.text.isDateTime) {
      showMessage(
          context, 'Data inválida', 'Verique novamente a data informada');
      return null;
    }
    print(edtTipo);
    if (edtTipo.text.isEmpty) {
      showMessage(context, 'Tipo inválido', 'Tipo de Atendimento em branco');
      return null;
    }

    try {
      idTipo = int.parse(edtTipo.text.split('|').first.trim().toString());
    } catch (e) {
      showMessage(context, 'Tipo inválido',
          'O Tipo de Atendimento deve conter inicialmente o código separado por |');
      return null;
    }

    try {
      tipo = TiposAtendimento.singleWhere((element) => element.id == idTipo);
    } catch (e) {
      showMessage(context, 'Tipo inválido',
          'Tipo de Atendimento não cadastrado, verifique novamente na lista');
      return null;
    }

    if (edtDescricao.text.isEmpty) {
      showMessage(context, 'Descrição inválida',
          'Informe uma descrição para o agendamento');
      return null;
    }

    if (edtPaciente.text.isEmpty) {
      showMessage(context, 'Nome inválido', 'Nome do paciente em branco');
      return null;
    }

    try {
      idPaciente =
          int.parse(edtPaciente.text.split('|').first.trim().toString());
    } catch (e) {
      showMessage(context, 'Nome inválido',
          'O nome do paciente deve conter inicialmente o código separado por |');
      return null;
    }

    try {
      paciente =
          _pacientes.todosPacientes.singleWhere((e) => e.id == idPaciente);
    } catch (e) {
      showMessage(context, 'Paciente não econtrado',
          'Paciente não cadastrado, verifique novamente na lista');
      return null;
    }

    if (edtHoraInicio.text.isEmpty) {
      showMessage(
          context, 'Hora Inicial Inválida', 'Horário inicial em branco');
      return null;
    }

    try {
      horaIni = DateFormat('HH:mm').parse(edtHoraInicio.text);
    } catch (e) {
      showMessage(context, 'Hora Inicial Inválida',
          'Verifique o horário inicial do agendamento (Exe. 13:00)');
      return null;
    }

    if (edtHoraFim.text.isEmpty) {
      showMessage(context, 'Hora Final Inválida', 'Horário final em branco');
      return null;
    }

    try {
      horaFim = DateFormat('HH:mm').parse(edtHoraFim.text);
    } catch (e) {
      showMessage(context, 'Hora Final Inválida',
          'Verifique o horário final do agendamento (Exe. 13:00)');
      return null;
    }

    atendimento.data = DateFormat('dd/MM/yyyy').parse(edtData.text);
    atendimento.idTipo = idTipo;
    atendimento.descricao = edtDescricao.text;
    atendimento.idPaciente = idPaciente;
    atendimento.horaInicio = TimeOfDay.fromDateTime(horaIni);
    atendimento.horaFim = TimeOfDay.fromDateTime(horaFim);

    _atendimentos
        .adicionar(atendimento)
        .then((value) => {Navigator.of(context).pop()});
  }

  @override
  Widget build(BuildContext context) {
    return (AlertDialog(
      title: const Text('Agendamento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 150, child: WdgDatePickerNew(myController: edtData)),
              SizedBox(width: 30),
              SizedBox(
                  width: 250,
                  child: WdgEdtTiposAtendimento(myController: edtTipo)),
            ],
          ),
          // SizedBox(
          //     height: 70,
          //     child: WdgEdtDescricao(
          //       myController: edtDescricao,
          //       label: 'Descrição',
          //     )),
          SizedBox(
              height: 70, child: WdgEdtPaciente(myController: edtPaciente)),
          // Row(
          //   children: [
          //     WdgEdtHora(
          //         myController: edtHoraInicio, label: 'Horário Inicial'),
          //     const SizedBox(width: 30),
          //     WdgEdtHora(myController: edtHoraFim, label: 'Horário Final'),
          //   ],
          // )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("CANCELAR")),
        ElevatedButton(
            onPressed: () {
              _gravar();
            },
            child: const Text(
              "CONFIRMAR",
              style: TextStyle(color: Colors.white),
            )),
      ],
    ));
  }
}
