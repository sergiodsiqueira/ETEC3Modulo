import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:intl/intl.dart';
import 'package:get/get.dart';

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

  DateTime? data;
  TimeOfDay? horaFim;
  TimeOfDay? horaInicio;

  @override
  void initState() {
    edtData.text = DateFormat('dd/MM/yyyy').format(widget.pAtendimento.data!);
    edtTipo.text =
        TiposAtendimento.singleWhere((e) => e.id == widget.pAtendimento.idTipo)
            .descricao
            .toString();
    edtDescricao.text = widget.pAtendimento.descricao.toString();
    edtPaciente.text = widget.pAtendimento.idPaciente.toString() +
        ' | ' +
        widget.pAtendimento.nome.toString();

    edtHoraInicio.text =
        widget.pAtendimento.horaInicio.toString().substring(10);
    edtHoraInicio.text = edtHoraInicio.text.substring(0, 5);

    edtHoraFim.text = widget.pAtendimento.horaFim.toString().substring(10);
    edtHoraFim.text = edtHoraFim.text.substring(0, 5);

    edtObservacoes.text = widget.pAtendimento.observacao.toString();
    edtValor.text = widget.pAtendimento.valor.toString() == 'null'
        ? ''
        : UtilBrasilFields.obterReal(widget.pAtendimento.valor!);
    edtPago = widget.pAtendimento.pago!;
    edtConfirmado = widget.pAtendimento.confirmado!;
    edtEfetivado = widget.pAtendimento.efetivado!;

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
      print('Error on generating data ' + error.toString());
    }

    print(atendimento.toJson().toString().trim());
    _atendimentos
        .alterar(atendimento)
        .then((value) => {Navigator.of(context).pop()});
  }

  @override
  Widget build(BuildContext context) {
    return ((AlertDialog(
      title: const Text('Atendimento'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: SizedBox(
        width: 500,
        height: 470,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 180, child: WdgEdtData(myController: edtData)),
                SizedBox(width: 30),
                SizedBox(
                    width: 289,
                    child: WdgEdtTiposAtendimento(myController: edtTipo)),
              ],
            ),
            SizedBox(
              height: 70,
              child: WdgEdtSimples(
                  myController: edtDescricao,
                  label: 'Descrição',
                  placehold: 'Informe a descrição do agendamento'),
            ),
            SizedBox(
                height: 70, child: WdgEdtPaciente(myController: edtPaciente)),
            Row(
              children: [
                WdgEdtHora(
                    myController: edtHoraInicio, label: 'Horário Inicial'),
                const SizedBox(width: 30),
                WdgEdtHora(myController: edtHoraFim, label: 'Horário Final'),
              ],
            ),
            WdgEdtObservacoes(
              myController: edtObservacoes,
            ),
            Row(
              children: [
                SizedBox(
                    width: 200, child: WdgEdtValor(myController: edtValor)),
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
                SizedBox(width: 20),
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
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("CANCELAR")),
        const SizedBox(width: 30),
        ElevatedButton(
            onPressed: () {
              _gravar();
            },
            child: const Text(
              "CONFIRMAR",
              style: TextStyle(color: Colors.white),
            )),
      ],
    )));
  }
}
