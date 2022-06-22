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
  final edtData = TextEditingController();
  final edtDescricao = TextEditingController();
  final edtHoraFim = TextEditingController();
  final edtHoraInicio = TextEditingController();
  final edtPaciente = TextEditingController();
  final edtTipo = TextEditingController();
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
    edtPaciente.text = widget.pAtendimento.idPaciente.toString() +
        ' | ' +
        widget.pAtendimento.nome.toString();
    edtData.text = DateFormat('dd/MM/yyyy').format(widget.pAtendimento.data!);
    edtHoraInicio.text = widget.pAtendimento.horaInicio.toString();
    edtHoraFim.text = widget.pAtendimento.horaFim.toString();
    edtDescricao.text = widget.pAtendimento.descricao.toString();
    edtTipo.text = widget.pAtendimento.descricao.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ((AlertDialog(
      title: const Text('Agendamento'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: SizedBox(
        width: 500,
        height: 600,
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
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
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
                InfoLabel(
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
              ],
            ),
            WdgEdtValor(myController: edtValor),
            SizedBox(height: 50),
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
                      atendimento.idPaciente = int.parse(
                          edtPaciente.text.split('|').first.toString().trim());
                      atendimento.horaInicio =
                          parseTimeOfDay(edtHoraInicio.text.toString());
                      atendimento.horaFim =
                          parseTimeOfDay(edtHoraFim.text.toString());
                      atendimento.descricao = edtDescricao.text;
                      var tipoAtendimento = TiposAtendimento.firstWhere(
                          (e) => e.descricao == edtTipo.text);
                      atendimento.idTipo = tipoAtendimento.id;

                      print(atendimento.toJson().toString());
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
    )));
  }
}
