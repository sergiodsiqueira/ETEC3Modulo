import 'package:flutter/material.dart';
import 'package:eclinic/src/view/eclinic.view.login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
