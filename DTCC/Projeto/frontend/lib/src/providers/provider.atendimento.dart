import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/components/components.dart';

class Atendimentos extends GetxController {
  final Login _login = Get.find<Login>();
  final RxList<Atendimento> _todosAtendimentos = RxList<Atendimento>.empty();

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
            if (dados.length > 0){
              for (int i = 0; i < dados.length; i++){
                Map<String,dynamic> map = dados[i];
                _todosAtendimentos.add(Atendimento.fromJson(map));
                print('asasass' + _todosAtendimentos.length.toString());
              }
            }
            return ApiResponse.ok(_todosAtendimentos);
          }

          return ApiResponse.error("Erro ao carregar atendimentos");
        } catch (error, exception) {
          return ApiResponse.error("Sem comunica��o ... tente mais tarde... ");
        }
      };
  List<Atendimento> get todosAtendimentos {
    return [..._todosAtendimentos];
  }

  //Lista de atendimentos efetivados
  List<Atendimento> get efetivados {
    return _todosAtendimentos.where((x) => x.efetivado.value == true).toList();
  }

  //Adicionar ao efetivados
  void efetivar(int id) {
    final int index = _todosAtendimentos.indexWhere((x) => x.id == id);
    _todosAtendimentos[index].efetivado.value = true;
  }
}
