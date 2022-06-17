import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';

DateTime turnDataBRtoDataUS(String pData) {
  DateTime DataUS =
      DateTime.parse(Jiffy(pData, "dd/MM/yyyy").format("yyyy-MM-dd"));
  return DataUS;
}

String turnDataUStoDataBR(DateTime pData) {
  return DateFormat('dd/MM/yyyy').format(pData);
}

String turnDateTimetoHour24H(DateTime pHora) {
  DateTime hora24 = DateFormat.Hm().parse(pHora.toString());
  return "${hora24.hour}:${hora24.minute}";
}

class TurnTimeOfDaytoHour24H {
  TimeOfDay fHora;
  TurnTimeOfDaytoHour24H({required this.fHora});

  converter() {
    DateTime hora24 = DateFormat.Hm().parse(fHora.toString());
    String strHora24 = "${hora24.hour}:${hora24.minute}";
    if (strHora24.split(':').last.toString() == '0') {
      return strHora24 += '0';
    } else {
      return strHora24;
    }
  }
}
