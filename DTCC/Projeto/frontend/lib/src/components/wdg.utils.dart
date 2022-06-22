import 'package:flutter/material.dart' hide IconButton, showDialog, Icon;
import 'package:intl/intl.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/providers/providers.dart';

parseTimeOfDay(String t) {
  DateTime dateTime = DateFormat("HH:mm").parse(t);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

// WdgEdtPaciente --------------------------------------------------------------
class WdgEdtPaciente extends StatefulWidget {
  final TextEditingController myController;
  const WdgEdtPaciente({Key? key, required this.myController})
      : super(key: key);

  @override
  State<WdgEdtPaciente> createState() => _WdgEdtPaciente();
}

class _WdgEdtPaciente extends State<WdgEdtPaciente> {
  final Pacientes _lista = Get.find<Pacientes>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InfoLabel(
        label: 'Paciente',
        child: (AutoSuggestBox(
          clearButtonEnabled: false,
          items: _lista.todosPacientes
              .map((e) => e.id.toString() + " | " + e.nome.toString())
              .toList(),
          onSelected: (item) {
            setState(() => {});
          },
          controller: widget.myController,
          placeholder: 'Informe o Paciente',
          leadingIcon: const Padding(
              padding: EdgeInsetsDirectional.only(start: 10),
              child: Icon(FluentIcons.contact)),
          trailingIcon: const Icon(FluentIcons.chevron_down),
        )),
      ),
    );
  }
}

// WdgEdtData ------------------------------------------------------------------
class WdgEdtData extends StatefulWidget {
  final TextEditingController myController;
  const WdgEdtData({Key? key, required this.myController}) : super(key: key);

  @override
  State<WdgEdtData> createState() => _WdgEdtData();
}

class _WdgEdtData extends State<WdgEdtData> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: TextFormBox(
        readOnly: true,
        controller: widget.myController,
        header: 'Data',
        placeholder: 'Escolha uma data',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text == null || text.isEmpty) return 'Campo obrigatório';
          return null;
        },
        textInputAction: TextInputAction.next,
        prefix: const Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0),
          child: Icon(FluentIcons.calendar),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100));

          if (pickedDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
            setState(() {
              value = formattedDate;
              widget.myController.text = value;
            });
          }
        },
      ),
    ));
  }
}

// WdgEmail --------------------------------------------------------------------
class WdgEdtEmail extends StatefulWidget {
  final TextEditingController myController;
  const WdgEdtEmail({Key? key, required this.myController}) : super(key: key);

  @override
  State<WdgEdtEmail> createState() => _WdgEdtEmail();
}

class _WdgEdtEmail extends State<WdgEdtEmail> {
  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: TextFormBox(
        controller: widget.myController,
        header: 'E-mail',
        placeholder: 'Digite seu e-mail',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text == null || text.isEmpty) return 'Campo obrigatório';
          if (!EmailValidator.validate(text)) return 'E-mail inválido';
          return null;
        },
        textInputAction: TextInputAction.next,
        prefix: const Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0),
          child: Icon(FluentIcons.edit_mail),
        ),
      ),
    ));
  }
}

// WdgSenha --------------------------------------------------------------------
class WdgEdtSenha extends StatefulWidget {
  final TextEditingController myController;
  const WdgEdtSenha({Key? key, required this.myController}) : super(key: key);

  @override
  State<WdgEdtSenha> createState() => _WdgEdtSenha();
}

class _WdgEdtSenha extends State<WdgEdtSenha> {
  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: TextFormBox(
        obscureText: true,
        controller: widget.myController,
        header: 'Senha',
        placeholder: 'Digite a senha',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text == null || text.isEmpty) return 'Campo obrigatório';
          return null;
        },
        textInputAction: TextInputAction.next,
        prefix: const Padding(
          padding: EdgeInsetsDirectional.only(start: 8.0),
          child: Icon(FluentIcons.password_field),
        ),
      ),
    ));
  }
}

//WdgEdtHora -------------------------------------------------------------------
class WdgEdtHora extends StatefulWidget {
  final TextEditingController myController;
  final String label;
  const WdgEdtHora({Key? key, required this.myController, required this.label})
      : super(key: key);

  @override
  State<WdgEdtHora> createState() => _WdgEdtHora();
}

class _WdgEdtHora extends State<WdgEdtHora> {
  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: TextFormBox(
          readOnly: true,
          controller: widget.myController,
          header: widget.label,
          placeholder: 'Defina um ' + widget.label,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (text) {
            if (text == null || text.isEmpty) return 'Campo obrigatório';
            return null;
          },
          textInputAction: TextInputAction.next,
          prefix: const Padding(
            padding: EdgeInsetsDirectional.only(start: 8.0),
            child: Icon(FluentIcons.clock),
          ),
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
                String pHora = "${pickedTime.hour}:${pickedTime.minute}";
                if (pHora.split(':').last.toString() == '0') {
                  pHora += '0';
                }
                if (pHora.split(':').first.toString() == '0') {
                  pHora += '0';
                }
                widget.myController.text = pHora;
              });
            }
          }),
    ));
  }
}

// WdgEdtSimples ---------------------------------------------------------------
class WdgEdtSimples extends StatelessWidget {
  final TextEditingController myController;
  final String label;
  final String placehold;
  const WdgEdtSimples(
      {Key? key,
      required this.myController,
      required this.label,
      required this.placehold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: TextFormBox(
        controller: myController,
        header: label,
        placeholder: placehold,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text == null || text.isEmpty) return 'Campo obrigatório';
          return null;
        },
        textInputAction: TextInputAction.next,
        prefix: const Padding(
            padding: EdgeInsetsDirectional.only(start: 8.0),
            child: Icon(FluentIcons.context_menu)),
      ),
    ));
  }
}

// WdgEdtTiposAtendimento ------------------------------------------------------
class WdgEdtTiposAtendimento extends StatefulWidget {
  final TextEditingController myController;
  const WdgEdtTiposAtendimento({Key? key, required this.myController})
      : super(key: key);

  @override
  State<WdgEdtTiposAtendimento> createState() => _WdgEdtTiposAtendimento();
}

class _WdgEdtTiposAtendimento extends State<WdgEdtTiposAtendimento> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InfoLabel(
        label: 'Tipo',
        child: (AutoSuggestBox(
          clearButtonEnabled: false,
          items: TiposAtendimento.map((e) => e.descricao).toList(),
          onSelected: (item) {
            setState(() => {
                  TiposAtendimento.firstWhere(
                      (tipos) => tipos.descricao == item)
                });
          },
          controller: widget.myController,
          placeholder: 'Tipo de Atendimento',
          leadingIcon: const Padding(
              padding: EdgeInsetsDirectional.only(start: 10),
              child: Icon(FluentIcons.bulleted_tree_list)),
          trailingIcon: const Icon(FluentIcons.chevron_down),
        )),
      ),
    );
  }
}

// WdgApagarAtendimento --------------------------------------------------------
class WdgApagarAtendimento extends StatefulWidget {
  final Atendimento pAtendimento;
  const WdgApagarAtendimento({Key? key, required this.pAtendimento})
      : super(key: key);

  @override
  State<WdgApagarAtendimento> createState() => _WdgApagarAtendimentoState();
}

class _WdgApagarAtendimentoState extends State<WdgApagarAtendimento> {
  final Atendimentos _lista = Get.find<Atendimentos>();

  void showContentDialog(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Apagar'),
        content: widget.pAtendimento.efetivado!
            ? const Text('Não é possivel apagar este atendimento!')
            : const Text(
                'Deseja realmente apagar o atendimento?',
              ),
        actions: [
          ElevatedButton(
            child: const Text('CONFIRMAR'),
            onPressed: widget.pAtendimento.efetivado!
                ? null
                : () {
                    Navigator.pop(context);
                    _lista.apagar(widget.pAtendimento.id!);
                  },
          ),
          ElevatedButton(
            child: const Text('CANCELAR'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
    //setState(() {}); Poderia aqui mudar algo na tela aonde o componente está
  }

  @override
  Widget build(BuildContext context) {
    return (IconButton(
      icon: const Icon(FluentIcons.delete),
      onPressed: () => showContentDialog(context),
    ));
  }
}

// WdgEditarAtendimento --------------------------------------------------------
class WdgEditarAtendimento extends StatefulWidget {
  final Atendimento? pAtendimento;
  const WdgEditarAtendimento({Key? key, required this.pAtendimento})
      : super(key: key);

  @override
  State<WdgEditarAtendimento> createState() => _WdgEditarAtendimentoState();
}

class _WdgEditarAtendimentoState extends State<WdgEditarAtendimento> {
  void showContentDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => ScreenAtendimento(
              pAtendimento: widget.pAtendimento!,
              pIdTipoAtendimento:
                  int.parse(widget.pAtendimento!.idTipo.toString()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return (IconButton(
      icon: const Icon(FluentIcons.edit),
      onPressed: () => showContentDialog(context),
    ));
  }
}

// WdgIconEfetivado ------------------------------------------------------------
class WdgIconEfetivado extends StatelessWidget {
  const WdgIconEfetivado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (const Icon(FluentIcons.skype_circle_check));
  }
}

// WdgEdtObservacoes------------------------------------------------------------
class WdgEdtObservacoes extends StatelessWidget {
  final TextEditingController myController;
  const WdgEdtObservacoes({Key? key, required this.myController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: TextFormBox(
        maxLines: null,
        minHeight: 100,
        controller: myController,
        header: 'Observações',
        textInputAction: TextInputAction.next,
        prefix: const Padding(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: Icon(FluentIcons.paste)),
      ),
    ));
  }
}

// WdgEdtValor -----------------------------------------------------------------
class WdgEdtValor extends StatelessWidget {
  final TextEditingController myController;
  const WdgEdtValor({Key? key, required this.myController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Expanded(
      child: TextFormBox(
        controller: myController,
        header: 'Valor',
        placeholder: 'Informe o valor',
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CentavosInputFormatter(moeda: true)
        ],
        textInputAction: TextInputAction.next,
        prefix: const Padding(
            padding: EdgeInsetsDirectional.only(start: 8.0),
            child: Icon(FluentIcons.circle_dollar)),
      ),
    ));
  }
}

// WdgInfoBar ------------------------------------------------------------------
class WdgInfoBar extends StatefulWidget {
  final String pTitulo;
  final String pMensagem;
  final int pSeveridade;

  const WdgInfoBar(
      {Key? key,
      required this.pTitulo,
      required this.pMensagem,
      required this.pSeveridade})
      : super(key: key);

  @override
  State<WdgInfoBar> createState() => _WdgInfoBarState();
}

class _WdgInfoBarState extends State<WdgInfoBar> {
  bool? show = false;

  severidade() {
    switch (widget.pSeveridade) {
      case 1:
        {
          return InfoBarSeverity.success;
        }
      case 2:
        {
          return InfoBarSeverity.error;
        }
      case 3:
        {
          return InfoBarSeverity.warning;
        }

      default:
        return InfoBarSeverity.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (InfoBar(
        title: Text(''),
        content: Text(widget.pMensagem),
        severity: severidade(),
        isLong: false,
        onClose: () => setState(() => show = false)));
  }
}
