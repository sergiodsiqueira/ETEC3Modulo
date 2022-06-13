import 'package:get/get.dart';

class Atendimento {
  final _id = 0.obs;
  get id => _id.value;
  set id(value) => _id.value = value;

  final _idPaciente = 0.obs;
  get idPaciente => _idPaciente.value;
  set idPaciente(value) => _idPaciente.value = value;

  final _data = ''.obs;
  get data => _data.value;
  set data(value) => _data.value = value;

  final _horaInicio = ''.obs;
  get horaInicio => _horaInicio.value;
  set horaInicio(value) => _horaInicio.value = value;

  final _horaFim = ''.obs;
  get horaFim => _horaFim.value;
  set horaFim(value) => _horaFim.value = value;

  final _descricao = ''.obs;
  get descricao => _descricao.value;
  set descricao(value) => _descricao.value = value;

  final _observacao = ''.obs;
  get observacao => _observacao.value;
  set observacao(value) => _observacao.value = value;

  final _confirmado = false.obs;
  get confirmado => _confirmado.value;
  set confirmado(value) => _confirmado.value = value;

  final _efetivado = false.obs;
  get efetivado => _efetivado.value;
  set efetivado(value) => _efetivado.value = value;

  final _valor = 0.obs;
  get valor => _valor.value;
  set valor(value) => _valor.value = value;

  final _pago = false.obs;
  get pago => _pago.value;
  set pago(value) => _pago.value = value;

  final _idTipo = 0.obs;
  get idTipo => _idTipo.value;
  set idTipo(value) => _idTipo.value = value;

  Atendimento(
      {id,
      idPaciente,
      data,
      horaInicio,
      horaFim,
      descricao,
      observacao,
      confirmado,
      efetivado,
      valor,
      pago,
      idTipo});

  Atendimento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPaciente = json['id_paciente'];
    data = json['data'];
    horaInicio = json['hora_inicio'];
    horaFim = json['hora_fim'];
    descricao = json['descricao'];
    observacao = json['observacao'];
    confirmado = json['confirmado'];
    efetivado = json['efetivado'];
    valor = json['valor'];
    pago = json['pago'];
    idTipo = json['id_tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_paciente'] = this.idPaciente;
    data['data'] = this.data;
    data['hora_inicio'] = this.horaInicio;
    data['hora_fim'] = this.horaFim;
    data['descricao'] = this.descricao;
    data['observacao'] = this.observacao;
    data['confirmado'] = this.confirmado;
    data['efetivado'] = this.efetivado;
    data['valor'] = this.valor;
    data['pago'] = this.pago;
    data['id_tipo'] = this.idTipo;
    return data;
  }
}
