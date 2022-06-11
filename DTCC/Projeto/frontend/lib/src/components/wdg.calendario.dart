import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendario extends StatefulWidget {
  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    return (SfDateRangePicker(
      monthCellStyle: const DateRangePickerMonthCellStyle(
          blackoutDateTextStyle:
              TextStyle(decoration: TextDecoration.lineThrough)),
      monthViewSettings: DateRangePickerMonthViewSettings(
        showTrailingAndLeadingDates: true,
      ),
      showNavigationArrow: true,
    ));
  }
}
