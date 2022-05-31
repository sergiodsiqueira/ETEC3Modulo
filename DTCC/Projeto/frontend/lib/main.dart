import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './src/view/pages.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'OFICINA DA MENTE',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
      locale: const Locale('pt'),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
