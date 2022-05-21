import 'package:eclinic/components/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eclinic/components/components.dart';
import 'eclinic.view.home.dart';

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
  return Container(
    margin: const EdgeInsets.all(2.0),
    color: Color.fromARGB(255, 240, 240, 240),
    width: 500.0,
    height: 400.0,
    child: Padding(
      padding:
          const EdgeInsets.only(left: 150, right: 150, bottom: 100, top: 100),
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
            decoration: const InputDecoration(
              icon: Icon(Icons.mail),
              hintText: '',
              labelText: 'E-mail',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              hintText: '',
              labelText: 'Senha',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()));
            },
            child: Text('LOGIN'),
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
