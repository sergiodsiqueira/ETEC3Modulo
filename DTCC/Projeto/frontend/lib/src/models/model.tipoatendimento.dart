class TipoAtendimento {
  final int id;
  final String descricao;

  TipoAtendimento({required this.id, required this.descricao});
}

final List<TipoAtendimento> TiposAtendimento = [
  TipoAtendimento(id: 0, descricao: "0 | Pessoal"),
  TipoAtendimento(id: 1, descricao: "1 | Ansiedade"),
  TipoAtendimento(id: 2, descricao: "2 | Depressão"),
  TipoAtendimento(id: 3, descricao: "3 | Relacionamento"),
  TipoAtendimento(id: 4, descricao: "4 | Famíliar")
];
