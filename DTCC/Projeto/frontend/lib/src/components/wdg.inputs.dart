import 'package:flutter/material.dart' hide IconButton, showDialog, Icon;
import 'package:fluent_ui/fluent_ui.dart' hide Colors, ListTile;
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/providers/providers.dart';

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
      controller: widget.myController,
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
        setState(() {
          String? id = value.item?.id.toString();
          String? nome = value.item?.nome.toString();
          String? x = id! + ' | ' + nome!;
          widget.myController.text = x;
        });
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

//WdgEdtHora -------------------------------------------------------------------
class WdgEdtHora extends StatelessWidget {
  TextEditingController myController = TextEditingController();
  final String label;
  final TimeOfDay? pHora;
  WdgEdtHora(
      {Key? key, required this.myController, required this.label, this.pHora})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      timeFieldWidth: 130,
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
  final int? pIdTipo;
  const WdgEdtTiposAtendimento(
      {Key? key, required this.myController, this.pIdTipo})
      : super(key: key);

  @override
  State<WdgEdtTiposAtendimento> createState() => _WdgEdtTiposAtendimento();
}

class _WdgEdtTiposAtendimento extends State<WdgEdtTiposAtendimento> {
  TipoAtendimento? tipoAtendimento;

  @override
  void initState() {
    if (widget.pIdTipo != null) {
      try {
        tipoAtendimento = TiposAtendimento.singleWhere(
            (element) => element.id == widget.pIdTipo);
      } catch (error) {
        tipoAtendimento = null;
      }
    } else {
      tipoAtendimento = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchField<TipoAtendimento>(
      controller: widget.myController,
      initialValue: tipoAtendimento != null
          ? SearchFieldListItem<TipoAtendimento>(
              tipoAtendimento!.id.toString() +
                  ' | ' +
                  tipoAtendimento!.descricao.toString(),
              item: tipoAtendimento)
          : null,
      searchInputDecoration: InputDecoration(
          icon: const Icon(FluentIcons.category_classification),
          label: const Text('Tipo de Atendimento')),
      suggestions: TiposAtendimento.map(
        (e) => SearchFieldListItem<TipoAtendimento>(
          e.id.toString() + ' | ' + e.descricao.toString(),
          item: e,
        ),
      ).toList(),
      onSuggestionTap: (value) {
        setState(() {
          String? id = value.item?.id.toString();
          String? desc = value.item?.descricao.toString();
          String? x = id! + ' | ' + desc!;
          widget.myController.text = x;
        });
      },
    );
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
    return TextFormField(
        controller: myController,
        decoration: const InputDecoration(
            icon: Icon(FluentIcons.circle_dollar), label: Text('Valor')),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CentavosInputFormatter(moeda: true)
        ],
        textInputAction: TextInputAction.next);
  }
}

//WdgEdtHoraNew ----------------------------------------------------------------
class WdgEdtHoraNew extends StatefulWidget {
  final TextEditingController myController;
  final String pLabel;
  const WdgEdtHoraNew(
      {Key? key, required this.myController, required this.pLabel})
      : super(key: key);

  @override
  State<WdgEdtHoraNew> createState() => _WdgEdtHoraNewState();
}

class _WdgEdtHoraNewState extends State<WdgEdtHoraNew> {
  Future<void> _selecionar() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        widget.myController.text = UtilData.obterHoraHHMM(
            DateTime(0000, 0, 0, result.hour, result.minute));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.myController,
      decoration: InputDecoration(
        labelText: widget.pLabel.toString(),
        icon: const Icon(FluentIcons.clock),
      ),
      onTap: () {
        _selecionar();
      },
    );
  }
}
