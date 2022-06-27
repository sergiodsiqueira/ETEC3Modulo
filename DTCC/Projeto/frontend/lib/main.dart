import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors, ThemeData;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:eclinic/src/providers/providers.dart';
import 'package:eclinic/src/screens/screens.dart';

void main() => runApp(const Application());

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FluentApp(
        title: 'OFICINA DA MENTE',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: LoadingAnimationWidget.discreteCircle(
              color: const Color.fromARGB(255, 71, 117, 245),
              size: 200,
            ),
            nextScreen: const MyApp(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FluentApp(
        onGenerateTitle: () {
          Providers _providers = Providers();
          _providers.start();
        }(),
        title: 'OFICINA DA MENTE',
        // ignore: prefer_const_literals_to_create_immutables
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: [
          const Locale('pt'),
        ],
        locale: const Locale('pt'),
        debugShowCheckedModeBanner: false,
        home: const ScreenLogin(),
      ),
    );
  }
}
