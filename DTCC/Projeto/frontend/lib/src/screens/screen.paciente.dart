import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

import 'package:eclinic/src/components/components.dart';
import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/providers/providers.dart';

final Pacientes _pacientes = Get.find<Pacientes>();

class ScreenPacientes extends StatelessWidget {
  const ScreenPacientes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (ScaffoldPage.scrollable(
      children: [
        Container(
          width: 100,
          height: 40,
          child: Button(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(FluentIcons.calculator), Text('data')],
              ),
              onPressed: () {}),
        )
      ],
    ));
  }
}
