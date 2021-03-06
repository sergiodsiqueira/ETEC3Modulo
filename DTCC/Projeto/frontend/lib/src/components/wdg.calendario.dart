import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/providers/providers.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  final Atendimentos _todosAtendimentos = Get.find<Atendimentos>();
  final _controller = DateRangePickerController();

  void carregarLista(DateRangePickerSelectionChangedArgs args) {
    _todosAtendimentos.dataSelecionada.value =
        args.value.toString().substring(0, 10);
    _todosAtendimentos.carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return (SfDateRangePicker(
      controller: _controller,
      selectionShape: DateRangePickerSelectionShape.rectangle,
      onSelectionChanged: carregarLista,
      monthCellStyle: const DateRangePickerMonthCellStyle(
          blackoutDateTextStyle:
              TextStyle(decoration: TextDecoration.lineThrough)),
      monthViewSettings: const DateRangePickerMonthViewSettings(
        showTrailingAndLeadingDates: true,
      ),
      showNavigationArrow: true,
    ));
  }
}
