import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class wdgGraphicLine extends StatelessWidget {
  const wdgGraphicLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Chart(
      data: [
        {'genre': 'Sports', 'sold': 275},
        {'genre': 'Strategy', 'sold': 115},
        {'genre': 'Action', 'sold': 120},
        {'genre': 'Shooter', 'sold': 350},
        {'genre': 'Other', 'sold': 150},
      ],
      variables: {
        'genre': Variable(
          accessor: (Map map) => map['genre'] as String,
        ),
        'sold': Variable(
          accessor: (Map map) => map['sold'] as num,
        ),
      },
      elements: [IntervalElement()],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
    ));
  }
}
