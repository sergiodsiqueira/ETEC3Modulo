import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final MeetingDataSource _events = MeetingDataSource(<_Meeting>[]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfCalendar(
        showDatePickerButton: true,
        view: CalendarView.month,
        dataSource: _events,
        loadMoreWidgetBuilder: loadMoreWidget,
        onTap: (CalendarTapDetails details) {
          showAlertDialog1(context, details.date.toString());
        },
      ),
    );
  }
}

//-----------------------
Widget loadMoreWidget(
    BuildContext context, LoadMoreCallback loadMoreAppointments) {
  return FutureBuilder<void>(
    initialData: 'loading',
    future: loadMoreAppointments(),
    builder: (context, snapShot) {
      return Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator());
    },
  );
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    http.Response data = await http.get(Uri.parse(
        "https://js.syncfusion.com/demos/ejservices/api/Schedule/LoadData"));
    dynamic jsonData = json.decode(data.body);

    final List<_Meeting> appointmentData = [];
    for (dynamic data in jsonData) {
      _Meeting meetingData = _Meeting(
          data['Subject'],
          _convertDateFromString(
            data['StartTime'],
          ),
          _convertDateFromString(data['EndTime']),
          Colors.red,
          false);
      appointmentData.add(meetingData);
    }

    appointments.addAll(appointmentData);
    notifyListeners(CalendarDataSourceAction.add, appointmentData);
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}

class _Meeting {
  _Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

showAlertDialog1(BuildContext context, String pData) {
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text(pData),
    content: Text("Não perca a promoção."),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
