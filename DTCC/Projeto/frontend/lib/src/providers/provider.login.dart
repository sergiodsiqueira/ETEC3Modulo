import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/models/models.dart';

class LoginApi {
  static Future<ApiResponse<Login>> login(String pEmail, String pSenha) async {
    final Login _login = Get.find<Login>();
    try {
      String url = 'https://app-eclinic-oficinadamente.herokuapp.com/api/login';

      Map params = {'login': pEmail, 'senha': pSenha};

      var body = json.encode(params);

      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);

      var Json = json.decode(response.body);
      _login.id = Json["id"];
      _login.login = Json["login"];
      _login.tipo = Json["tipo"];
      _login.id_cliente = Json["id_cliente"];
      _login.x_access_token = Json["x-access-token"];

      if (response.statusCode == 200) {
        final usuario = Login.fromJson(json.decode(response.body));
        return ApiResponse.ok(usuario);
      }

      return ApiResponse.error("Erro ao fazer o login");
    } catch (error, exception) {
      return ApiResponse.error("Sem comunica��o ... tente mais tarde... ");
    }
  }
}
