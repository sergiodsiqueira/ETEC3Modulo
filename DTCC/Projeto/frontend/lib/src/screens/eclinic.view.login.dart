import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:eclinic/components/components.dart';
import 'screens.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

//Componentes ------------------------------------------------------------------
Widget LoginBox(BuildContext context) {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

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
            style: subtitleTextStyle,
          ),
          Text(
            'OFICINA DA MENTE',
            style: bodyTextStyle,
          ),
          TextFormField(
            controller: txtEmail,
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
            controller: txtSenha,
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
              if (txtSenha.text != '' && txtEmail.text != '') {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home()));
              }
            },
            child: Text('ENTRAR'),
          )
        ],
      ),
    ),
  );
}

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
