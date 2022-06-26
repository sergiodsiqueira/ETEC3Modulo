import 'package:flutter/material.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/providers/providers.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);
  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Align(
      alignment: Alignment.bottomCenter,
      child: Wrap(alignment: WrapAlignment.center, children: [
        Container(height: 100),
        welcomeBox(context),
        loginBox(context)
      ]),
    )));
  }
}

//Container Imagem
Widget welcomeBox(BuildContext context) {
  return Container(
      margin: const EdgeInsets.all(2.0),
      color: const Color.fromARGB(255, 240, 240, 240),
      width: 300.0,
      height: 400.0,
      child: const Image(
        image: NetworkImage(
            'https://rehabafterwork.pyramidhealthcarepa.com/wp-content/uploads/2020/03/Online-Counseling-and-Confidentiality.jpg'),
        fit: BoxFit.cover,
      ));
}

//Container Login
Widget loginBox(BuildContext context) {
  final _tEmail = TextEditingController();
  final _tSenha = TextEditingController();

  _onClickEntrar(BuildContext context) async {
    // final login = _tEmail.text;
    // final senha = _tSenha.text;

    final login = 'admin@local.com';
    final senha = '12345678';

    ApiResponse response = await LoginApi.login(login, senha);

    if (response.ok) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ScreenHome()));
    } else {
      showMessage(context, "Login", "Erro ao efetuar login");
    }
  }

  return SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.all(2.0),
      color: const Color.fromARGB(255, 240, 240, 240),
      width: 500.0,
      height: 400.0,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 80, right: 80, bottom: 60, top: 40),
        child: Column(
          children: [
            const Text(
              'BEM-VINDO',
            ),
            const SizedBox(
              width: 200,
              child: Image(
                image: NetworkImage(
                    'https://raw.githubusercontent.com/sergiodsiqueira/ETEC3Modulo/main/DTCC/Projeto/images/LogoMarcaPB.png'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            WdgEdtEmail(myController: _tEmail),
            const SizedBox(height: 10),
            WdgEdtSenha(myController: _tSenha),
            const SizedBox(height: 20),
            Container(
              width: 250,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: () {
                  _onClickEntrar(context);
                },
                child: const Text('ENTRAR'),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
