import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/models/models.dart';

class ScreenEditaPaciente extends StatefulWidget {
  final Paciente? paciente;
  const ScreenEditaPaciente({Key? key, this.paciente}) : super(key: key);

  @override
  State<ScreenEditaPaciente> createState() => _ScreenEditaPacienteState();
}

class _ScreenEditaPacienteState extends State<ScreenEditaPaciente> {
  final Pacientes _pacientes = Get.find<Pacientes>();

  TextEditingController edtNome = TextEditingController();
  TextEditingController edtDataNascimento = TextEditingController();
  TextEditingController edtEmail = TextEditingController();
  TextEditingController edtTelefone1 = TextEditingController();
  TextEditingController edtTelefone2 = TextEditingController();
  TextEditingController edtLogradouro = TextEditingController();
  TextEditingController edtBairro = TextEditingController();
  TextEditingController edtCidade = TextEditingController();
  TextEditingController edtCEP = TextEditingController();
  TextEditingController edtEstado = TextEditingController();
  TextEditingController edtPais = TextEditingController();
  TextEditingController edtCPF = TextEditingController();
  TextEditingController edtRG = TextEditingController();
  TextEditingController edtRedeSocial1 = TextEditingController();
  TextEditingController edtRedeSocial2 = TextEditingController();
  TextEditingController edtObservacoes = TextEditingController();

  @override
  void initState() {
    if (widget.paciente == null) return null;

    edtNome.text = widget.paciente.toString();
    edtDataNascimento.text = widget.paciente!.data_nascimento.toString();
    edtEmail.text = widget.paciente!.email ?? '';
    edtTelefone1.text = widget.paciente!.telefone_principal ?? '';
    edtTelefone2.text = widget.paciente!.telefone_secundario ?? '';
    edtLogradouro.text = widget.paciente!.end_logradouro ?? '';
    edtBairro.text = widget.paciente!.end_bairro ?? '';
    edtCidade.text = widget.paciente!.end_cidade ?? '';
    edtCEP.text = widget.paciente!.end_cep ?? '';
    edtEstado.text = widget.paciente!.end_estado ?? '';
    edtPais.text = widget.paciente!.end_pais ?? '';
    edtRG.text = widget.paciente!.doc_rg ?? '';
    edtCPF.text = widget.paciente!.doc_cpf ?? '';
    edtRedeSocial1.text = widget.paciente!.redesocial_1 ?? '';
    edtRedeSocial2.text = widget.paciente!.redesocial_2 ?? '';
    edtObservacoes.text = widget.paciente!.observacoes ?? '';

    super.initState();
  }

  _gravar() {
    Paciente paciente = Paciente();
    try {
      if (edtNome.text.isEmpty) {
        showMessage(context, 'Nome do paciente em branco', 'Campo obrigatório');
        return null;
      }
      if (edtEmail.text.isEmpty) {
        showMessage(context, 'Email em branco', 'Campo obrigatório');
        return null;
      }
    } catch (e) {
      errorPrint(e.toString(), 'screen.paciente', 'ScreenPaciente', '_gravar');
    }

    paciente.nome = edtNome.text;
    paciente.data_nascimento = edtDataNascimento.text.isEmpty
        ? null
        : DateFormat('yyyy-MM-dd').parse(edtDataNascimento.text);
    paciente.email = edtEmail.text;
    paciente.telefone_principal = edtTelefone1.text;
    paciente.telefone_secundario = edtTelefone2.text;
    paciente.end_logradouro = edtLogradouro.text;
    paciente.end_bairro = edtBairro.text;
    paciente.end_cidade = edtCidade.text;
    paciente.end_estado = edtEstado.text;
    paciente.end_pais = edtPais.text;
    paciente.end_cep = edtCEP.text;
    paciente.doc_rg = edtRG.text;
    paciente.doc_cpf = edtCPF.text;
    paciente.redesocial_1 = edtRedeSocial1.text;
    paciente.redesocial_2 = edtRedeSocial2.text;
    paciente.observacoes = edtObservacoes.text;

    _pacientes.adicionar(paciente).then((value) =>
        {showMessage(context, 'Sucesso', 'Paciente gravado com sucesso')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 450,
                        child: WdgEdtPadrao(
                            myController: edtNome,
                            pLabel: 'Nome do Paciente',
                            pIcone: const Icon(FluentIcons.contact)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 250,
                        child: WdgEdtData(
                            myController: edtDataNascimento,
                            pLabel: 'Data de Nascimento'),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 350,
                        child: WdgEdtPadrao(
                            myController: edtEmail,
                            pLabel: 'E-mail',
                            pIcone: const Icon(FluentIcons.mail)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 165,
                        child: WdgEdtTelefone(
                            myController: edtTelefone1,
                            pLabel: 'Celular',
                            pIcone: const Icon(FluentIcons.cell_phone)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 165,
                        child: WdgEdtTelefone(
                            myController: edtTelefone2,
                            pLabel: 'Telefone',
                            pIcone: const Icon(FluentIcons.phone)),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 450,
                        child: WdgEdtPadrao(
                            myController: edtLogradouro,
                            pLabel: 'Logradouro',
                            pIcone: const Icon(FluentIcons.home)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 250,
                        child: WdgEdtPadrao(
                            myController: edtBairro,
                            pLabel: 'Bairro',
                            pIcone: const Icon(FluentIcons.map_pin)),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 250,
                        child: WdgEdtPadrao(
                            myController: edtCidade,
                            pLabel: 'Cidade',
                            pIcone: const Icon(FluentIcons.map_pin_solid)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 150,
                        child: WdgEdtPadrao(
                            myController: edtEstado,
                            pLabel: 'Estado',
                            pIcone: const Icon(FluentIcons.map_pin12)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 130,
                        child: WdgEdtPadrao(
                            myController: edtPais,
                            pLabel: 'Pais',
                            pIcone: const Icon(FluentIcons.globe2)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 130,
                        child: WdgEdtCEP(myController: edtCEP),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 160,
                        child: WdgEdtPadrao(
                            myController: edtRG,
                            pLabel: 'RG',
                            pIcone: const Icon(FluentIcons.i_d_badge)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 180,
                        child:
                            WdgEdtCPFCNPJ(myController: edtCPF, pLabel: 'CPF'),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: 300,
                        child: WdgEdtPadrao(
                            myController: edtRedeSocial1,
                            pLabel: 'Rede Social',
                            pIcone: const Icon(FluentIcons.group)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 300,
                        child: WdgEdtPadrao(
                            myController: edtRedeSocial2,
                            pLabel: 'Rede Social',
                            pIcone: const Icon(FluentIcons.group)),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                      width: 720,
                      child: WdgEdtObs(myController: edtObservacoes)),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _gravar();
                          },
                          child: const Text("CONFIRMAR")),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("CANCELAR")),
                    ],
                  ),
                )
              ],
            )));
  }
}
