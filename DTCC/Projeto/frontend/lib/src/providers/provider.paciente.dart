import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/components/components.dart';

class Pacientes extends GetxController {
  final Login _login = Get.find<Login>();
  final RxList<Paciente> _todosPacientes = <Paciente>[].obs;
  final RxString x_access_token = ''.obs;
  late String feedback = '';
  late String _dados = '';

  //Carga de dados
  get carregarDados => () async {
        _todosPacientes.clear();

        if (x_access_token.value == '') {
          x_access_token.value = _login.x_access_token;
        }

        try {
          String url =
              "https://app-eclinic-oficinadamente.herokuapp.com/api/pacientes";
          var response = await http.get(Uri.parse(url), headers: {
            "Content-Type": "application/json",
            'x-access-token': x_access_token.toString()
          });

          if (response.statusCode == 200) {
            var dados = json.decode(response.body);
            for (var el in dados) {
              Paciente paciente = Paciente();
              try {
                print(response.toString());
                paciente.id = el['id'];
                paciente.nome = el['nome'];
                paciente.email = el['email'];
                paciente.data_nascimento =
                    DateTime.parse(el['data_nascimento']);
                paciente.telefone_principal = el['telefone_principal'];
                paciente.telefone_secundario = el['telefone_secundario'];
                paciente.end_logradouro = el['end_logradouro'];
                paciente.end_bairro = el['end_bairro'];
                paciente.end_cidade = el['end_cidade'];
                paciente.end_estado = el['end_estado'];
                paciente.end_pais = el['end_pais'];
                paciente.doc_cpf = el['doc_cpf'];
                paciente.doc_rg = el['doc_rg'];
                paciente.redesocial_1 = el['redesocial_1'];
                paciente.redesocial_2 = el['redesocial_2'];
                paciente.observacoes = el['observacoes'];
                paciente.end_cep = el['end_cep'];
              } catch (e) {
                print(e);
              }
              _todosPacientes.add(paciente);
            }
          } else {
            return ApiResponse.error("Erro ao carregar os atendimentos");
          }
        } catch (error) {
          return ApiResponse.error(
              "Servidor não responde... tente mais tarde...");
        }
      };

  //Lista de todos Atendimentos
  List<Paciente> get todosPacientes {
    return [..._todosPacientes];
  }

  Future<void> adicionar(Paciente pPaciente) async {
    if (pPaciente.id! > 0) {
      feedback = 'Impossivel incluir este Paciente';
      return;
    } else {
      gerarDados(pPaciente);
    }

    final url = Uri.parse(
        'https://app-eclinic-oficinadamente.herokuapp.com/api/pacientes');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'x-access-token': x_access_token.toString(),
        },
        body: _dados);
    if (response.statusCode >= 400) {
      feedback = response.body;
    } else {
      feedback = response.body;
      carregarDados();
    }
  }

  Future<void> alterar(Paciente pPaciente) async {
    if (pPaciente.id == 0) {
      feedback = 'Impossivel alterar este atendimento';
      return;
    } else {
      gerarDados(pPaciente);
    }

    final url = Uri.parse(
        'https://app-eclinic-oficinadamente.herokuapp.com/api/pacientes/${pPaciente.id.toString()}');
    final response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          'x-access-token': x_access_token.toString(),
        },
        body: _dados);
    if (response.statusCode >= 400) {
      feedback = response.body;
    } else {
      feedback = response.body;
      carregarDados();
    }
  }

  Future<void> apagar(int pID) async {
    final url = Uri.parse(
        'https://app-eclinic-oficinadamente.herokuapp.com/api/pacientes/${pID.toString()}');
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        'x-access-token': x_access_token.toString(),
      },
    );
    if (response.statusCode >= 400) {
      feedback = response.body;
    } else {
      feedback = response.body;
      carregarDados();
    }
  }

  gerarDados(Paciente pPaciente) {
    print('Gerando dados...');
    _dados += '{';
    _dados += '"nome": "${pPaciente.nome}",';
    _dados += '"email": "${pPaciente.email}",';
    _dados += '"data_nascimento": "${pPaciente.data_nascimento}",';
    _dados += '"telefone_principal": "${pPaciente.telefone_principal}"';
    _dados += '"telefone_secundario": "${pPaciente.telefone_secundario}"';
    _dados += '"end_logradouro": "${pPaciente.end_logradouro}",';
    _dados += '"end_bairro": "${pPaciente.end_bairro}",';
    _dados += '"end_cidade": "${pPaciente.end_cidade}",';
    _dados += '"end_estado": "${pPaciente.end_estado}",';
    _dados += '"end_cep": "${pPaciente.end_cep}",';
    _dados += '"end_pais": "${pPaciente.end_pais}",';
    _dados += '"doc_cpf": "${pPaciente.doc_cpf}",';
    _dados += '"doc_rg": "${pPaciente.doc_rg}",';
    _dados += '"redesocial_1": "${pPaciente.redesocial_1}",';
    _dados += '"redesocial_2": "${pPaciente.redesocial_2}",';
    _dados += '"observacoes": "${pPaciente.observacoes}"';
    _dados += '}';
    print('Dados gerados...');
  }
}
