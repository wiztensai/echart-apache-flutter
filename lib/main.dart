import 'dart:convert';

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
