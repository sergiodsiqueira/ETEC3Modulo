import 'package:flutter/material.dart';

class ScreenHistorico extends StatefulWidget {
  const ScreenHistorico({Key? key}) : super(key: key);

  @override
  State<ScreenHistorico> createState() => _ScreenHistoricoState();
}

class _ScreenHistoricoState extends State<ScreenHistorico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('HISTÓRICO'));
  }
}
