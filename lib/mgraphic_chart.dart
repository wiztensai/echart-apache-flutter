import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  ['2015-01-31',500000000, "Hitam", 1250, "Surabaya", 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'],
  ['2016-11-30',400000000, "Putih", 12300, "DKI Jakarta", 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80'],
  ['2017-02-02',335000000, "Silver", 26520, "DKI Jakarta", 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'],
  ['2017-04-20',400000000, "Putih", 23200, "Bandung", 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80'],
  ['2018-03-03',200000000, "Abu-Abu", 41513, "DKI Jakarta", 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'],
];

/*data: [
{ 'date': '2015-01-31', 'price': 500000000 },
{ 'date': '2016-11-30', 'price': 400000000 },
{ 'date': '2017-02-02', 'price': 335000000 },
],*/

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

class MGraphicChart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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
                  selected: {
                    'tap': Set()
                  } ,
                  size: SizeAttr(value: 20),
                  color: ColorAttr(
                    value: Colors.blue,
                    updaters: {
                      'tap': {false: (color) => color.withAlpha(70)},
                    },
                  ),

              )],
              // coord: RectCoord(color: const Color(0xffdddddd)),
              // selections: {'choose': PointSelection(toggle: true)},
              selections: {'tap': PointSelection(

              )},

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