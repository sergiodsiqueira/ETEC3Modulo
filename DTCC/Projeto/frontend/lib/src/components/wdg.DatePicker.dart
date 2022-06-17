import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluent_ui/fluent_ui.dart';

class wdgDatePicker extends StatefulWidget {
  @override
  State<wdgDatePicker> createState() => _wdgDatePickerState();
}

class _wdgDatePickerState extends State<wdgDatePicker> {
  TextEditingController edtDatePicker = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return (Center(
        child: TextFormField(
      controller: edtDatePicker,
      decoration: InputDecoration(
          icon: Icon(FluentIcons.calendar_agenda), //icon of text field
          labelText: "Data" //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
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
        } else {
          print("Date is not selected");
        }
      },
    )));
  }
}
