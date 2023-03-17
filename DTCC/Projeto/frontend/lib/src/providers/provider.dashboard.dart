import 'package:brasil_fields/brasil_fields.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';

final Login _login = Get.find<Login>();

class DashboardAPI {
  static Future carregarGrafico1() async {
    String ano = UtilData.obterDataDDMMAAAA(DateTime.now());
    ano = ano.substring(6, 10);

    String url =
        "https://eclinic-teal.vercel.app/api/dashboard/1/${int.parse(ano)}";

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      'x-access-token': _login.x_access_token
    });
    return response;
  }
}
