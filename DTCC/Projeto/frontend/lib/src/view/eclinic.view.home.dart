import 'package:eclinic/components/calendar.dart';
import 'package:flutter/material.dart';
import 'package:eclinic/components/components.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const MenuBar(),
                  Row(
                    children: [
                      Container(
                        transformAlignment: Alignment.topCenter,
                        child: Calendar(),
                        width: 500,
                        height: 500,
                      ),
                      Container(
                        width: 800,
                        height: 500,
                        color: Colors.amberAccent,
                      )
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
