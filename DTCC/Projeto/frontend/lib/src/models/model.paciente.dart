class Paciente {
  int? id = 0;
  String? nome = '';
  String? email = '';
  DateTime? data_nascimento = null;
  String? telefone_principal = '';
  String? telefone_secundario = '';
  String? end_logradouro = '';
  String? end_bairro = '';
  String? end_cidade = '';
  String? end_estado = '';
  String? end_pais = '';
  String? doc_cpf = '';
  String? doc_rg = '';
  String? redesocial_1 = '';
  String? redesocial_2 = '';
  String? observacoes = '';
  String? end_cep = '';

  Paciente({
    id,
    nome,
    email,
    data_nascimento,
    telefone_principal,
    telefone_secundario,
    end_logradouro,
    end_bairro,
    end_cidade,
    end_estado,
    end_pais,
    doc_cpf,
    doc_rg,
    redesocial_1,
    redesocial_2,
    observacoes,
    end_cep,
  });

  Paciente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
    data_nascimento = json['data_nascimento'];
    telefone_principal = json['telefone_principal'];
    telefone_secundario = json['telefone_secundario'];
    end_logradouro = json['end_logradouro'];
    end_bairro = json['end_bairro'];
    end_cidade = json['end_cidade'];
    end_estado = json['end_estado'];
    end_pais = json['end_pais'];
    doc_cpf = json['doc_cpf'];
    doc_rg = json['doc_rg'];
    redesocial_1 = json['redesocial_1'];
    redesocial_2 = json['redesocial_2'];
    observacoes = json['observacoes'];
    end_cep = json['end_cep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['data_nascimento'] = this.data_nascimento;
    data['telefone_principal'] = this.telefone_principal;
    data['telefone_secundario'] = this.telefone_secundario;
    data['end_logradouro'] = this.end_logradouro;
    data['end_bairro'] = this.end_bairro;
    data['end_cidade'] = this.end_cidade;
    data['end_estado'] = this.end_estado;
    data['end_pais'] = this.end_pais;
    data['doc_cpf'] = this.doc_cpf;
    data['doc_rg'] = this.doc_rg;
    data['redesocial_1'] = this.redesocial_1;
    data['redesocial_2'] = this.redesocial_2;
    data['observacoes'] = this.observacoes;
    data['end_cep'] = this.end_cep;
    return data;
  }
}
