import 'package:eclinic/src/providers/provider.atendimento.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';
export 'package:eclinic/src/providers/provider.login.dart';
export 'package:eclinic/src/providers/provider.atendimento.dart';

class StartProviders {
  late Login login;
  late Atendimento atendimento;
  late Atendimentos atendimentos;

  start() {
    this.login = Get.put(Login());
    this.atendimento = Get.put(Atendimento());
    this.atendimentos = Get.put(Atendimentos());
  }
}
