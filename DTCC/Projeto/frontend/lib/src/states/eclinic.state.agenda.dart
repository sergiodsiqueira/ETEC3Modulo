// state/products.dart
import 'package:get/get.dart';
import 'dart:math';
import '../models/eclinic.model.agenda.dart';

class Agendamentos extends GetxController {
  // Todos Agendamentos
  // Carregar da API
  final RxList<Agendamento> _eventos = List.generate(
      10,
      (index) => Agendamento(
            id: index,
            evento: 'Evento $index',
            observacao: 'Atendimento ao paciente Ansiedade',
            data: DateTime.now(),
            horaInicial: DateTime.now(),
            horaFinal: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, DateTime.now().hour + 1),
            confirmado: false.obs, //Variavel a ser observada
            idTipoEvento: Random().nextInt(3),
            descricaoTipoEvento: 'Atendimento',
            idPaciente: index,
            nomePaciente: 'Paciente' + index.toString(),
          )).obs;

  //Lista todos os agendamentos confirmados ou não
  List<Agendamento> get items {
    return [..._eventos];
  }

  //Lista de Confirmados
  List<Agendamento> get listaConfirmados {
    return _eventos.where((item) => item.confirmado.value == true).toList();
  }

  //Metodo Adicionar a lista de Atendimentos Confirmados
  void addItem(int id) {
    final int index = _eventos.indexWhere((item) => item.id == id);
    _eventos[index].confirmado.value = true;
  }

  //Metodo Remover da lista de Atendimentos Confirmados
  void removeItem(int id) {
    final int index = _eventos.indexWhere((item) => item.id == id);
    _eventos[index].confirmado.value = false;
  }
}
