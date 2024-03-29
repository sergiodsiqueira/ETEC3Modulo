import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors;

import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/components/components.dart';

class ScreenAtendimento extends StatefulWidget {
  final Atendimento pAtendimento;

  const ScreenAtendimento({Key? key, required this.pAtendimento})
      : super(key: key);

  @override
  State<ScreenAtendimento> createState() => _ScreenAtendimentoState();
}

class _ScreenAtendimentoState extends State<ScreenAtendimento> {
  final Atendimentos _atendimentos = Get.find<Atendimentos>();
  final Pacientes _pacientes = Get.find<Pacientes>();

  final edtData = TextEditingController();
  final edtTipo = TextEditingController();
  final edtDescricao = TextEditingController();
  final edtPaciente = TextEditingController();
  final edtHoraFim = TextEditingController();
  final edtHoraInicio = TextEditingController();
  final edtObservacoes = TextEditingController();
  bool edtConfirmado = false;
  bool edtEfetivado = false;
  bool edtPago = false;
  final edtValor = TextEditingController();

  @override
  void initState() {
    edtData.text = DateFormat('dd/MM/yyyy').format(widget.pAtendimento.data!);
    edtDescricao.text = widget.pAtendimento.descricao.toString();

    edtHoraInicio.text = UtilData.obterHoraHHMM(DateTime(
        0000,
        0,
        0,
        widget.pAtendimento.horaInicio!.hour,
        widget.pAtendimento.horaInicio!.minute));

    edtHoraFim.text = UtilData.obterHoraHHMM(DateTime(
        0000,
        0,
        0,
        widget.pAtendimento.horaFim!.hour,
        widget.pAtendimento.horaFim!.minute));

    edtObservacoes.text = widget.pAtendimento.observacao.toString();

    edtValor.text = widget.pAtendimento.valor.toString() == 'null'
        ? '000'
        : UtilBrasilFields.obterReal(widget.pAtendimento.valor!);

    edtPago =
        widget.pAtendimento.pago == null ? false : widget.pAtendimento.pago!;
    edtConfirmado = widget.pAtendimento.confirmado == null
        ? false
        : widget.pAtendimento.confirmado!;
    edtEfetivado = widget.pAtendimento.efetivado == null
        ? false
        : widget.pAtendimento.efetivado!;

    super.initState();
  }

  _gravar() {
    Atendimento atendimento = Atendimento();
    int? idTipo;
    TipoAtendimento? tipo;
    int? idPaciente;
    Paciente? paciente;
    DateTime horaIni;
    DateTime horaFim;
    String valor;

    if (edtData.text.isEmpty && !edtData.text.isDateTime) {
      showMessage(
          context, 'Data inválida', 'Verique novamente a data informada');
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

    if (edtValor.text.isEmpty) {
      valor = '0';
    } else {
      valor =
          edtValor.text.toString().replaceAll(RegExp(r'[R./\+$]'), '').trim();
      valor = valor.replaceAll(',', '.');
    }

    try {
      atendimento.id = widget.pAtendimento.id;
      atendimento.data = DateFormat('dd/MM/yyyy').parse(edtData.text);
      atendimento.idTipo = idTipo;
      atendimento.descricao = edtDescricao.text;
      atendimento.idPaciente = idPaciente;
      atendimento.horaInicio = TimeOfDay.fromDateTime(horaIni);
      atendimento.horaFim = TimeOfDay.fromDateTime(horaFim);
      atendimento.observacao = edtObservacoes.text;
      atendimento.valor = double.parse(valor);
      atendimento.pago = edtPago;
      atendimento.confirmado = edtConfirmado;
      atendimento.efetivado = edtEfetivado;
    } catch (error) {
      errorPrint(error.toString(), 'screen.atendimento', 'ScreenAtendimento',
          '_gravar');
    }

    _atendimentos
        .alterar(atendimento)
        .then((value) => {Navigator.of(context).pop()});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atendimento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 150, child: WdgEdtData(myController: edtData)),
              const SizedBox(width: 20),
              SizedBox(
                  width: 250,
                  child: WdgEdtTiposAtendimento(
                      myController: edtTipo,
                      pIdTipo: widget.pAtendimento.idTipo)),
            ],
          ),
          SizedBox(
              child: WdgEdtDescricao(
            myController: edtDescricao,
            label: 'Descrição',
          )),
          SizedBox(
              child: WdgEdtPaciente(
                  myController: edtPaciente,
                  pIdPaciente: widget.pAtendimento.idPaciente)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 180,
                  child: WdgEdtHoraNew(
                      myController: edtHoraInicio, pLabel: 'Horário Inicial')),
              SizedBox(
                  width: 180,
                  child: WdgEdtHoraNew(
                      myController: edtHoraFim, pLabel: 'Horário Final')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 150, child: WdgEdtValor(myController: edtValor)),
              const SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: InfoLabel(
                  label: 'Pago',
                  child: Switch(
                    value: edtPago,
                    onChanged: (value) {
                      setState(() {
                        edtPago = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(width: 30),
              InfoLabel(
                label: 'Confirmado',
                child: Switch(
                  value: edtConfirmado,
                  onChanged: (value) {
                    setState(() {
                      edtConfirmado = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
              InfoLabel(
                label: 'Efetivado',
                child: Switch(
                  value: edtEfetivado,
                  onChanged: (value) {
                    setState(() {
                      edtEfetivado = value;
                    });
                  },
                ),
              ),
            ],
          ),
          WdgEdtObservacoes(myController: edtObservacoes),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              _gravar();
            },
            child: const Text(
              "CONFIRMAR",
              style: TextStyle(color: Colors.white),
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("CANCELAR")),
      ],
    );
  }
}
