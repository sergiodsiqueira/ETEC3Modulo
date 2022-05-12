import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    color: Colors.red[600],
    width: 600.0,
    height: 400.0,
    child: (Text('Inputs e Labels de Login')),
  );
}

Widget WelcomeBox(BuildContext context) {
  return Container(
      margin: const EdgeInsets.all(2.0),
      color: Colors.amber[600],
      width: 400.0,
      height: 400.0,
      child: (Image.network(
          'https://media.istockphoto.com/vectors/smartphone-screen-with-female-therapist-on-chat-vector-id1253363497')));
}
