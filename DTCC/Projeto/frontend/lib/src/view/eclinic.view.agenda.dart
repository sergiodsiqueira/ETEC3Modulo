import 'package:eclinic/components/calendar.dart';
import 'package:flutter/material.dart';
import 'package:eclinic/components/components.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Agenda extends StatefulWidget {
  @override
  State<Agenda> createState() => _AgendaState();
}

class _AgendaState extends State<Agenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        transformAlignment: Alignment.topCenter,
                        child: Calendar(),
                        width: 300,
                        height: 400,
                      ),
                      Container(
                          width: 500,
                          height: 400,
                          color: Colors.amberAccent,
                          child: (Column(
                            children: [Text('Ola'), Text('ola2'), Text('ola2')],
                          ))),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
