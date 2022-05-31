import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          locale: 'pt_BR',
          calendarFormat: CalendarFormat.month,
          headerVisible: false,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2100, 3, 14),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: DatePicker(
            selected: DateTime.now(),
            showDay: false,
          ),
        )
      ],
    );
  }
}
