import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/models/models.dart';

class ScreenHome extends StatefulWidget {
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final viewKey = GlobalKey();
  int index = 0;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        title: () {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FlutterLogo(
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'OFICINA DA MENTE',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ],
          );
        }(),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
          displayMode: PaneDisplayMode.compact,
          selected: index,
          onChanged: (i) => setState(() => index = i),
          header: Container(
            child: Text('Menu'),
          ),
          indicator: () {
            StickyNavigationIndicator();
          }(),
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.dashboard_add),
              title: const Text('Dashboard'),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.calendar_agenda),
              title: const Text('Agenda'),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.contact),
              title: const Text('Pacientes'),
            ),
            PaneItemSeparator(),
          ]),
      content: NavigationBody(index: index, children: [
        Dashboard(),
        TelaAgenda(),
      ]),
    );
  }
}
