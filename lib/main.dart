import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tes_djubli/mflutter_chart.dart';
import 'package:tes_djubli/mgraphic_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tes Djubli',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterChart(),
    );
  }
}
