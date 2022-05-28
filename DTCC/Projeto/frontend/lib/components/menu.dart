import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eclinic/components/color.dart';
import 'package:eclinic/components/text.dart';
import 'package:eclinic/routes.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: <Widget>[
              InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName)),
                child: Text("OFICINA DA MENTE",
                    style: GoogleFonts.montserrat(
                        color: textPrimary,
                        fontSize: 30,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w500)),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Wrap(
                    children: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.popUntil(context,
                            ModalRoute.withName(Navigator.defaultRouteName)),
                        style: menuButtonStyle,
                        child: const Text(
                          "AGENDA",
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: menuButtonStyle,
                        child: const Text(
                          "PACIENTES",
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.style),
                        style: menuButtonStyle,
                        child: const Text(
                          "ADMINISTRAÇÃO",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 30),
            color: const Color(0xFFEEEEEE)),
      ],
    );
  }
}
