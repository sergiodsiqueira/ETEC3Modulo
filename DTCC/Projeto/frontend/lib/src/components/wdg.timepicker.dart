import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluent_ui/fluent_ui.dart';

class WdgTimePicker extends StatefulWidget {
  const WdgTimePicker({Key? key}) : super(key: key);

  @override
  State<WdgTimePicker> createState() => _WdgTimePickerState();
}

class _WdgTimePickerState extends State<WdgTimePicker> {
  final edtTimerPicker = TextEditingController();
  final String label = 'Hora';

  @override
  Widget build(BuildContext context) {
    return (TextField(
      controller: edtTimerPicker,
      decoration:
          InputDecoration(icon: Icon(FluentIcons.timer), labelText: label),
      readOnly: true,
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
            edtTimerPicker.text = "${pickedTime.hour}:${pickedTime.minute}";
          });
        } else {
          print("Time is not selected");
        }
      },
    ));
  }
}
