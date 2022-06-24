import 'package:flutter/material.dart' hide IconButton, showDialog, Icon;
import 'package:intl/intl.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors, ListTile;
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';
import 'package:date_time_picker/date_time_picker.dart';

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
  final int? pIdPaciente;
  const WdgEdtPaciente({Key? key, required this.myController, this.pIdPaciente})
      : super(key: key);

  @override
  State<WdgEdtPaciente> createState() => _WdgEdtPaciente();
}

class _WdgEdtPaciente extends State<WdgEdtPaciente> {
  final Pacientes _lista = Get.find<Pacientes>();
  Paciente? paciente;

  @override
  void initState() {
    if (widget.pIdPaciente != null) {
      try {
        paciente = _lista.todosPacientes
            .singleWhere((element) => element.id == widget.pIdPaciente);
      } catch (error) {
        paciente = null;
      }
    } else {
      paciente = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchField<Paciente>(
      initialValue: paciente != null
          ? SearchFieldListItem<Paciente>(
              paciente!.id.toString() + ' | ' + paciente!.nome.toString(),
              item: paciente)
          : null,
      searchInputDecoration: const InputDecoration(
          icon: Icon(FluentIcons.contact), label: Text('Paciente')),
      suggestions: _lista.todosPacientes
          .map(
            (e) => SearchFieldListItem<Paciente>(
              e.id.toString() + ' | ' + e.nome.toString(),
              item: e,
            ),
          )
          .toList(),
      onSuggestionTap: (value) {
        String? id = value.item?.id.toString();
        String? nome = value.item?.nome.toString();
        String? x = id! + ' | ' + nome!;
        widget.myController.text = x;
      },
    );
  }
}

// WdgEdtData ------------------------------------------------------------------
class WdgEdtData extends StatelessWidget {
  TextEditingController myController = TextEditingController();
  WdgEdtData({Key? key, required this.myController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      type: DateTimePickerType.date,
      dateMask: 'dd/MM/yyyy',
      controller: myController,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: const Icon(FluentIcons.calendar),
      dateLabelText: 'Data',
      use24HourFormat: true,
      locale: const Locale('pt', 'BR'),
      selectableDayPredicate: (date) {
        if (date.weekday == 6 || date.weekday == 7) {
          return false;
        }
        return true;
      },
      onChanged: (val) => {},
      validator: (val) {},
      onSaved: (val) => {},
    );
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
          child: Icon(FluentIcons.clock),
        ),
      ),
    ));
  }
}

// //WdgEdtHora -------------------------------------------------------------------
class WdgEdtHora extends StatelessWidget {
  TextEditingController myController = TextEditingController();
  final String label;
  WdgEdtHora({Key? key, required this.myController, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      type: DateTimePickerType.time,
      dateMask: 'HH:mm',
      controller: myController,
      icon: const Icon(FluentIcons.clock),
      timeLabelText: label,
      use24HourFormat: true,
      locale: const Locale('pt', 'BR'),
      onChanged: (val) => {},
      validator: (val) {},
      onSaved: (val) => {},
    );
  }
}

// WdgEdtDescricao -------------------------------------------------------------
class WdgEdtDescricao extends StatelessWidget {
  final TextEditingController myController;
  final String label;
  const WdgEdtDescricao(
      {Key? key, required this.myController, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
          icon: Icon(FluentIcons.calendar_settings),
          label: Text('Descrição do Agendamento')),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (text) {
        if (text == null || text.isEmpty) return 'Campo obrigatório';
        return null;
      },
      textInputAction: TextInputAction.next,
    );
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
    return SearchField<TipoAtendimento>(
      searchInputDecoration: InputDecoration(
          icon: const Icon(FluentIcons.category_classification),
          label: const Text('Tipo de Atendimento')),
      suggestions: TiposAtendimento.map(
        (e) => SearchFieldListItem<TipoAtendimento>(
          e.id.toString() + ' | ' + e.descricao.toString(),
          item: e,
        ),
      ).toList(),
      textInputAction: TextInputAction.next,
      onSuggestionTap: (value) {
        String? id = value.item?.id.toString();
        String? desc = value.item?.descricao.toString();
        String? x = id! + ' | ' + desc!;
        widget.myController.text = x;
      },
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
        builder: (context) =>
            ScreenAtendimento(pAtendimento: widget.pAtendimento!));
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
      child: TextFormField(
        controller: myController,
        decoration: const InputDecoration(
            icon: Icon(FluentIcons.paste), label: Text('Observações')),
        maxLines: null,
        textInputAction: TextInputAction.next,
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
      child: TextFormField(
          controller: myController,
          decoration: const InputDecoration(
              icon: Icon(FluentIcons.circle_dollar), label: Text('Valor')),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CentavosInputFormatter(moeda: true)
          ],
          textInputAction: TextInputAction.next),
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
        title: Text(widget.pTitulo),
        content: Text(widget.pMensagem),
        severity: severidade(),
        isLong: true,
        onClose: () => setState(() => show = false)));
  }
}
