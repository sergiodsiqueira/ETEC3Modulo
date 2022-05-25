import 'package:flutter/material.dart';
import 'dart:math';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const Calendar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      allowAppointmentResize: true,
      showDatePickerButton: true,
      view: CalendarView.month,
      monthViewSettings: const MonthViewSettings(
          monthCellStyle: MonthCellStyle(leadingDatesBackgroundColor: Color.fromARGB(20, 0, 0, 0),),
          showAgenda: true,
          appointmentDisplayCount: 6,
          navigationDirection: MonthNavigationDirection.horizontal,
          agendaItemHeight: 70,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          ),
    );
  }
}
