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

// ErrorPrint ------------------------------------------------------------------
errorPrint(
    String pErrorMessage, String pArquivo, String pClasse, String pMetodo) {
  print(
      'Error: ${pErrorMessage} | File: ${pArquivo} | Class: ${pClasse} | Method ${pMetodo}');
}

// parseTimeofDay --------------------------------------------------------------
// Data em String para TimeOfDay
parseTimeOfDay(String t) {
  DateTime dateTime = DateFormat("HH:mm").parse(t);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
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
  @override
  Widget build(BuildContext context) {
    return (IconButton(
        icon: const Icon(FluentIcons.edit),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) =>
                  ScreenAtendimento(pAtendimento: widget.pAtendimento!));
        }));
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
