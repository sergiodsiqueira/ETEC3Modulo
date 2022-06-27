import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:eclinic/src/providers/providers.dart';

List<Dados> dados = [];
bool isLoading = true;

class Grafico extends StatefulWidget {
  const Grafico({Key? key}) : super(key: key);

  @override
  State<Grafico> createState() => _GraficoState();
}

class _GraficoState extends State<Grafico> {
  carregarDados() {
    DashboardAPI.carregarGrafico1().then((res) {
      setState(() {
        if ((res as http.Response).statusCode < 400) {
          var retorno = json.decode(res.body);
          for (var el in retorno) {
            try {
              print(el.toString());
              Dados item = Dados();
              item.mes = el['numero'];
              try {
                item.valor = (el['qtd'] as int).toDouble();
              } catch (e) {
                item.valor = 0;
              }
              dados.add(item);
            } catch (e) {
              print(e.toString());
            }
          }
          isLoading = false;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Jan.';
        break;
      case 2:
        text = 'Fev.';
        break;
      case 3:
        text = 'Mar.';
        break;
      case 4:
        text = 'Abr.';
        break;
      case 5:
        text = 'Mai.';
        break;
      case 6:
        text = 'Jun.';
        break;
      case 7:
        text = 'Jul.';
        break;
      case 8:
        text = 'Ago.';
        break;
      case 9:
        text = 'Set.';
        break;
      case 10:
        text = 'Out.';
        break;
      case 11:
        text = 'Nov.';
        break;
      case 12:
        text = 'Dez.';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  final _barsGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 249, 64, 255),
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[0].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[1].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[2].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[3].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[4].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[5].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[6].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[7].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[8].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[9].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[10].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 12,
          barRods: [
            BarChartRodData(
              toY: dados.isEmpty ? dados[11].valor! : 0,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class GraficoBarras extends StatefulWidget {
  const GraficoBarras({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GraficoBarrasState();
}

class GraficoBarrasState extends State<GraficoBarras> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3.7,
      child: isLoading
          ? const Text('Dados atualizados')
          : Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: Color.fromARGB(255, 255, 255, 255),
              child: const Grafico(),
            ),
    );
  }
}

class Dados {
  int? mes;
  double? valor;

  Dados({mes, valor});
}
