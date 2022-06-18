import 'package:eclinic/src/models/model.login.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import './provider.atendimento.dart';

export './provider.atendimento.dart';
export './provider.login.dart';

class Providers {
  Login _login = Get.put<Login>(Login());
  Atendimentos _atendimentos = Get.put<Atendimentos>(Atendimentos());

  start() {
    _atendimentos.carregarDados();
    Intl.defaultLocale = 'pt_BR';
  }
}
