import 'package:get/get.dart';
import 'dart:math';

import 'package:eclinic/src/models/model.atendimento.dart';

class Atendimentos extends GetxController {
  //Carga de dados
  final RxList<Atendimento> _atendimentos = List.generate(
      20,
      (index) => Atendimento(
          id: index, descricao: 'Evento $index', efetivado: false.obs)).obs;

  //Lista de todos atendimentos
  List<Atendimento> get atendimentos {
    return [..._atendimentos];
  }

  //Lista de atendimentos efetivados
  List<Atendimento> get efetivados {
    return _atendimentos.where((x) => x.efetivado.value == true).toList();
  }

  //Adicionar ao efetivados
  void efetivar(int id) {
    final int index = _atendimentos.indexWhere((x) => x.id == id);
    _atendimentos[index].efetivado.value = true;
  }
}
