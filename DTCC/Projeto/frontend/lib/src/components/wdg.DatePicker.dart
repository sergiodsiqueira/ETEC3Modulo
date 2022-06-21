import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WdgDatePicker extends StatefulWidget {
  const WdgDatePicker({Key? key}) : super(key: key);

  @override
  State<WdgDatePicker> createState() => _WdgDatePickerState();
}

class _WdgDatePickerState extends State<WdgDatePicker> {
  TextEditingController edtDatePicker = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return (Center(
        child: TextFormField(
      controller: edtDatePicker,
      decoration: const InputDecoration(
          icon: Icon(FluentIcons.calendar_agenda), labelText: "Data"),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100));

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          setState(() {
            edtDatePicker.text = formattedDate;
          });
        }
      },
    )));
  }
}
