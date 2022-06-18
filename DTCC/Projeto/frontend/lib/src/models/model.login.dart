import 'package:get/get.dart';

class Login extends GetxController {
  final _id = 0.obs;
  get id => _id.value;
  set id(value) => _id.value = value;

  final _login = ''.obs;
  get login => _login.value;
  set login(value) => _login.value = value;

  final _tipo = ''.obs;
  get tipo => _tipo.value;
  set tipo(value) => _tipo.value = value;

  final _id_cliente = 0.obs;
  get id_cliente => _id_cliente.value;
  set id_cliente(value) => _id_cliente.value = value;

  RxString _x_access_token = ''.obs;
  get x_access_token => _x_access_token.value;
  set x_access_token(value) => _x_access_token.value = value;

  Login({id, login, tipo, id_cliente, x_access_token});

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    tipo = json['tipo'];
    id_cliente = json['id_cliente'];
    x_access_token = json['x-access-token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['tipo'] = this.tipo;
    data['id_cliente'] = this.id_cliente;
    data['x-access-token'] = this.x_access_token;
    return data;
  }
}
