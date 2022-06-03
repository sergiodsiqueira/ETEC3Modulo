import 'package:flutter/material.dart';
import '../src/models/eclinic.model.agendamento.dart';

class wdgAgendamentos extends StatefulWidget {
  const wdgAgendamentos({Key? key}) : super(key: key);

  @override
  State<wdgAgendamentos> createState() => _wdgAgendamentosState();
}

class _wdgAgendamentosState extends State<wdgAgendamentos> {
  List<Agendamento> listaAgendamentos = [];

  void gerarAgendamentos(int pQtde) {
    for (var i = 0; i <= 15; i++) {
      listaAgendamentos.add(Agendamento(
          id: i,
          evento: 'Evento ' + i.toString(),
          observacao: 'Atendimento baseado no histórica de stress',
          data: DateTime.now(),
          horaInicial: DateTime.now(),
          horaFinal: DateTime.now(),
          confirmado: false,
          idTipoEvento: 1,
          descricaoTipoEvento: 'Ansiedade',
          idPaciente: i,
          nomePaciente: 'Paciente Silva ' + i.toString()));
    }
  }

  @override
  void initState() {
    gerarAgendamentos(10);
    for (var i = 0; i <= 9; i++) {
      print(listaAgendamentos[i].nomePaciente);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
        itemCount: listaAgendamentos.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  listaAgendamentos[index].evento,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                leading: CircleAvatar(
                  child: Text(
                    listaAgendamentos[index].evento[0],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: Text(
                    "\$ ${listaAgendamentos[index].horaInicial.toString()}"),
              ),
            ),
          );
        }));
  }
}
