import 'package:eclinic/src/models/model.login.dart';
import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/screens/screen.dashboard.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eclinic/src/providers/provider.atendimento.dart';
import 'package:eclinic/src/providers/provider.paciente.dart';
import 'package:eclinic/src/providers/provider.dashboard.dart';

export 'package:eclinic/src/providers/provider.atendimento.dart';
export 'package:eclinic/src/providers/provider.login.dart';
export 'package:eclinic/src/providers/provider.paciente.dart';
export 'package:eclinic/src/providers/provider.dashboard.dart';

class Providers {
  Login _login = Get.put<Login>(Login());
  Atendimentos _atendimentos = Get.put<Atendimentos>(Atendimentos());
  Pacientes _pacientes = Get.put<Pacientes>(Pacientes());

  start() {
    Intl.defaultLocale = 'pt_BR';
  }
}
