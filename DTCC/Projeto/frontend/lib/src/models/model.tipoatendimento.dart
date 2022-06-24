class TipoAtendimento {
  final int id;
  final String descricao;

  TipoAtendimento({required this.id, required this.descricao});
}

final List<TipoAtendimento> TiposAtendimento = [
  TipoAtendimento(id: 0, descricao: "Pessoal"),
  TipoAtendimento(id: 1, descricao: "Ansiedade"),
  TipoAtendimento(id: 2, descricao: "Depressão"),
  TipoAtendimento(id: 3, descricao: "Relacionamento"),
  TipoAtendimento(id: 4, descricao: "Famíliar")
];
