import 'package:eclinic/src/providers/provider.atendimento.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/models/models.dart';
export 'package:eclinic/src/providers/provider.login.dart';
export 'package:eclinic/src/providers/provider.atendimento.dart'
    show ProviderAtendimento;

class StartProviders {
  late Login login;
  late Atendimentos atendimentos;

  start() {
    this.login = Get.put(Login());
    this.atendimentos = Get.put(Atendimentos());
  }
}
