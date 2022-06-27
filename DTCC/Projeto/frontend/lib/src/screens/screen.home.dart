import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:url_launcher/link.dart';

import 'package:eclinic/src/screens/screens.dart';
import 'package:eclinic/src/providers/providers.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final viewKey = GlobalKey();
  int index = 0;
  bool value = false;

  // Carga inicial de dados ----------------------------------------------------
  final Atendimentos _atendimentos = Get.find<Atendimentos>();
  final Pacientes _pacientes = Get.find<Pacientes>();

  @override
  void initState() {
    print('Iniciando...');
    _atendimentos.carregarDados();
    _pacientes.carregarDados();
    super.initState();
  }
  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        title: () {
          return Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                      height: 30,
                      child: Image(
                        image: NetworkImage(
                            'https://raw.githubusercontent.com/sergiodsiqueira/ETEC3Modulo/main/DTCC/Projeto/images/LogoPB_90x96.png'),
                        fit: BoxFit.cover,
                      ))),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'OFICINA DA MENTE',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          );
        }(),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.minimal,
        selected: index,
        onChanged: (i) => setState(() => index = i),
        header: const Text('Menu'),
        indicator: () {
          const StickyNavigationIndicator();
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
        ],
        footerItems: [
          _LinkPaneItemAction(
            icon: const Icon(FluentIcons.plug_disconnected),
            title: const Text('Sair'),
            link: 'https://sergiodsiqueira.github.io/',
          ),
        ],
      ),
      content: NavigationBody(index: index, children: [
        ScreenDashboard(),
        const ScreenAgenda(),
        const ScreenPacientes(),
      ]),
    );
  }
}

class _LinkPaneItemAction extends PaneItem {
  _LinkPaneItemAction({
    required Widget icon,
    required this.link,
    title,
    infoBadge,
    focusNode,
    autofocus = false,
  }) : super(
          icon: icon,
          title: title,
          infoBadge: infoBadge,
          focusNode: focusNode,
          autofocus: autofocus,
        );

  final String link;

  @override
  Widget build(
    BuildContext context,
    bool selected,
    VoidCallback? onPressed, {
    PaneDisplayMode? displayMode,
    bool showTextOnTop = true,
    bool? autofocus,
  }) {
    return Link(
      uri: Uri.parse(link),
      builder: (context, followLink) => super.build(
        context,
        selected,
        followLink,
        displayMode: displayMode,
        showTextOnTop: showTextOnTop,
        autofocus: autofocus,
      ),
    );
  }
}
