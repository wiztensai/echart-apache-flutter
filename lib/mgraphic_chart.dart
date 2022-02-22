import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';

/*class MGraphicChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MGraphicChart();
  }
}*/

var datas = [
  ['2015-01-31',500000000, "Hitam", 1250],
  ['2016-11-30',400000000, "Putih", 12300],
  ['2017-02-02',335000000, "Silver", 26520],
  ['2017-04-20',400000000, "Putih", 23200],
  ['2018-03-03',200000000, "Abu-Abu", 41513],
];

class TimeSeriesSales {
  final DateTime time;
  final int price;

  TimeSeriesSales(this.time, this.price);
}

final timeSeriesSales = [
  TimeSeriesSales(DateTime(2015, 1, 31), 500000000),
  TimeSeriesSales(DateTime(2016, 11, 30), 400000000),
  TimeSeriesSales(DateTime(2017, 2, 2), 335000000),
  TimeSeriesSales(DateTime(2017, 4, 20), 400000000),
  TimeSeriesSales(DateTime(2018, 3, 3), 200000000),
];

final _monthDayFormat = DateFormat('yyyy');
final onClickChannel = StreamController<Selected?>.broadcast();

class MGraphicChart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    onClickChannel.stream.listen((event) {
      print(event); // index yang diklik
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Graphic Chart"),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: 350,
            height: 300,
            child: Chart(
              data: timeSeriesSales,
              variables: {
                'time': Variable(
                  accessor: (TimeSeriesSales datum) => datum.time,
                  scale: TimeScale(
                    tickCount: 5,
                    formatter: (time) => _monthDayFormat.format(time),
                  ),
                ),
                'sales': Variable(
                  accessor: (TimeSeriesSales datum) => datum.price,
                ),
              },
              elements: [PointElement(
                selectionChannel: onClickChannel,
                size: SizeAttr(value: 20),
                color: ColorAttr(
                  value: Colors.blue,
                  updaters: {
                    'tap': {false: (color) => color.withAlpha(70)},
                  },
                ),

              )],
              selections: {'tap': PointSelection()},
              axes: [
                Defaults.horizontalAxis,
                Defaults.verticalAxis,
              ],
            ),
          ),
        )

    );
  }
}