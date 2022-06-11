class Atendimento {
  int id;
  String evento;
  String observacao;
  DateTime data;
  DateTime horaInicial;
  DateTime horaFinal;
  bool confirmado;
  int idTipoEvento;
  String descricaoTipoEvento;
  int idPaciente;
  String nomePaciente;

  Atendimento({
    required this.id,
    required this.evento,
    required this.observacao,
    required this.data,
    required this.horaInicial,
    required this.horaFinal,
    required this.confirmado,
    required this.idTipoEvento,
    required this.descricaoTipoEvento,
    required this.idPaciente,
    required this.nomePaciente,
  });
}
