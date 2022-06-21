import 'package:flutter/material.dart' hide IconButton;
import 'package:intl/intl.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'dart:core';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

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
          items: _lista.todosPacientes.map((e) => e.nome.toString()).toList(),
          onSelected: (item) {
            setState(() => {print(item.toString())});
          },
          controller: widget.myController,
          placeholder: 'Digite o nome do paciente',
          leadingIcon: const Icon(FluentIcons.contact),
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
        controller: widget.myController,
        header: 'Data',
        placeholder: 'Escolha a data do agendamento',
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
        label: 'Tipos de Atendimento',
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
          placeholder: 'Selecione um tipo de atendimento',
          leadingIcon: const Icon(FluentIcons.bulleted_tree_list),
          trailingIcon: const Icon(FluentIcons.chevron_down),
        )),
      ),
    );
  }
}
