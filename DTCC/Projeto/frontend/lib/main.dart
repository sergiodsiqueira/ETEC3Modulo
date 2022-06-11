import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:eclinic/src/screens/screens.dart';

void main() => runApp(const Application());

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: LoadingAnimationWidget.discreteCircle(
              color: Colors.blueAccent,
              size: 200,
            ),
            nextScreen: MyApp(),
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
        home: ScreenLogin(),
      ),
    );
  }
}
