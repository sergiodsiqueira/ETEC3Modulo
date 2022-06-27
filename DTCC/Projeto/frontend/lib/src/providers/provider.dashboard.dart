import 'package:brasil_fields/brasil_fields.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';

final Login _login = Get.find<Login>();

class Dashboard extends GetxController {
  final RxList<int> _grafico1 = <int>[].obs;

  //Grafico 1 | dashboard/1/<ano> ---------------------------------------------
  get carregarDados => () async {
        _grafico1.clear();

        try {
          String ano = UtilData.obterDataDDMMAAAA(DateTime.now());
          ano = ano.substring(6, 10);

          String url =
              "https://app-eclinic-oficinadamente.herokuapp.com/api/dashboard/1/${int.parse(ano)}";

          final response = await http.get(Uri.parse(url), headers: {
            "Content-Type": "application/json",
            'x-access-token': _login.x_access_token.toString(),
          });

          if (response.statusCode >= 400) {
            print('Error');
          } else {
            var dados = json.decode(response.body);
            for (int i = 0; i <= 11; i++) {
              print('mes' + dados[i]['mes'].toString() == ''
                  ? i.toString()
                  : dados[i]['mes'].toString());
            }
          }
        } catch (e) {
          print(e.toString());
        }
      };

  List<int> get grafico1 {
    return [..._grafico1];
  }
}
