import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/components/components.dart';

class Atendimentos extends GetxController {
  final Login _login = Get.find<Login>();
  final RxList<Atendimento> _todosAtendimentos = <Atendimento>[].obs;

  //Carga de dados
  get carregarDados => () async {
        try {
          String url =
              'https://app-eclinic-oficinadamente.herokuapp.com/api/atendimentos';

          var response = await http.get(Uri.parse(url), headers: {
            "Content-Type": "application/json",
            'x-access-token': _login.x_access_token
          });
          print(response.body);

          if (response.statusCode == 200) {
            var dados = json.decode(response.body);
            for (var e in dados) {
              Atendimento item = Atendimento();
              item.id = e['id'];

              _todosAtendimentos.add(item);
            }

            for (var e in _todosAtendimentos) {
              print(e.id.toString());
            }
          } else {
            return ApiResponse.error("Erro ao carregar atendimentos");
          }
        } catch (error, exception) {
          return ApiResponse.error(
              "Sem comunica��o ... tente mais tarde... ");
        }
      };

  //Lista de todos Atendimentos
  List<Atendimento> get todosAtendimentos {
    return [..._todosAtendimentos];
  }

  //Lista de atendimentos efetivados
  List<Atendimento> get efetivados {
    return _todosAtendimentos.where((x) => x.efetivado == true).toList();
  }

  validar() {
    if (_todosAtendimentos.length > 0) {
      print('Tem coisas na lista');
      for (var item in _todosAtendimentos) {
        print(item.id.toString() + item.descricao.toString());
      }
    }
  }

  //Adicionar ao efetivados
  // void efetivar(int id) {
  //   final int index = _todosAtendimentos.indexWhere((x) => x.id == id);
  //   _todosAtendimentos[index].efetivado = true;
  // }
}
