import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/models/models.dart';
import 'package:eclinic/src/providers/providers.dart';

class ScreenLogin extends StatefulWidget {
  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Wrap(
        children: [
          WelcomeBox(context),
          LoginBox(context),
        ],
      )),
    ));
  }
}

//Container Imagem
Widget WelcomeBox(BuildContext context) {
  return Container(
      margin: const EdgeInsets.all(2.0),
      color: Color.fromARGB(255, 240, 240, 240),
      width: 300.0,
      height: 400.0,
      child: (Image(
        image: NetworkImage(
            'https://rehabafterwork.pyramidhealthcarepa.com/wp-content/uploads/2020/03/Online-Counseling-and-Confidentiality.jpg'),
        fit: BoxFit.cover,
      )));
}

//Container Login
Widget LoginBox(BuildContext context) {
  final _tEmail = TextEditingController();
  final _tSenha = TextEditingController();
  final Login _login = Get.put(Login());

  _onClickEntrar(BuildContext context) async {
    final login = _tEmail.text;
    final senha = _tSenha.text;

    ApiResponse response = await LoginApi.login(login, senha);

    if (response.ok) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ScreenHome()));
    } else {
      alert(context, "Login", "Erro ao efetuar login");
    }
  }

  return Container(
    margin: const EdgeInsets.all(2.0),
    color: Color.fromARGB(255, 240, 240, 240),
    width: 500.0,
    height: 400.0,
    child: Padding(
      padding:
          const EdgeInsets.only(left: 80, right: 80, bottom: 100, top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'BEM-VINDO',
          ),
          Text(
            'OFICINA DA MENTE',
          ),
          TextFormField(
            controller: _tEmail,
            decoration: const InputDecoration(
              icon: Icon(FluentIcons.mail),
              hintText: '',
              labelText: 'E-mail',
            ),
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
          TextFormField(
            controller: _tSenha,
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(FluentIcons.password_field),
              hintText: '',
              labelText: 'Senha',
            ),
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              _onClickEntrar(context);
            },
            child: Text('ENTRAR'),
          )
        ],
      ),
    ),
  );
}
