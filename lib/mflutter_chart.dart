import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:tes_djubli/utils.dart';

class FlutterChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FlutterChart();
  }
}

class _FlutterChart extends State<FlutterChart> {

  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool _show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _show = true;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nanang Fitrianto"),
        ),
        body: Container(
          color: Colors.white,
          child:  Column(
            children: [
              _show? Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 280,
                child: Echarts(
                  option: '''
    {
      xAxis : [
        {        
            name: 'Th.',
            type: 'time',
            axisLabel: {              
              formatter: {
              year: '{yyyy}',
              month: '',
              day: '',
              hour: '',
              minute: '',
              second: '',
              millisecond: '',
              none: '{yyyy}'
            },                            
              interval: 1,                
            },
        }
      ],
      
      yAxis: {
        name: 'Harga',
        type: 'value',
        scale: false,
        axisLabel:{
          formatter: function (value, index) {            
            return value/1000000;
          }
        }
      },
      
      series:
      [{
        data: ${jsonEncode(getCoords())},
        type: 'scatter',
        symbolSize: 24,
        markPoint: {
          symbol: 'pin',
          symbolSize: 40,
          data: [{ name: 'mark', xAxis: "${datas[_current][0].toString()}", yAxis: ${int.parse(datas[_current][1].toString())},
                  itemStyle: {
                    color: '#FF0000',
                  }
                }]
        },
      }]
      
    }
''',
                  extraScript: '''
                chart.on('click', (params) => {
                  if(params.componentType === 'series') {
                    Messager.postMessage(JSON.stringify({
                      type: 'select',
                      payload: params.dataIndex,                                    
                    }));
                  }
                });
''',
                  onMessage: (String message) {
                    jsonDecode(message);
                    var messageAction =  new Map<String, dynamic>.from(json.decode(message));
                    if (messageAction['type'] == 'select') {
                      var index = messageAction["payload"];
                      _controller.animateToPage(index);
                    }
                  },
                ),
              ) : Container(),
              carousel(context)
            ],
          ),
        )

    );
  }

  List<Widget> imageSliders (BuildContext context) {
    return datas
        .map((item) => Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Formater.dateFormat(item[0].toString())),
            Text(Formater.currencyFormat(int.parse(item[1].toString()))),
            Text("Warna ${item[2].toString()}"),
            Text("KM ${Formater.thousandFormat(item[3].toString())}"),
          ],
        ),
      ),
    ))
        .toList();
  }

  Flexible carousel(BuildContext context) {
    return Flexible(child: Column(children: [
      CarouselSlider(
        items: imageSliders(context),
        carouselController: _controller,
        options: CarouselOptions(
          height: 120,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: datas.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ]));
  }

  var datas = [
    ['2015-01-31',500000000, "Hitam", 1250],
    ['2016-11-30',400000000, "Putih", 12300],
    ['2017-02-02',335000000, "Silver", 26520],
    ['2017-04-20',400000000, "Putih", 23200],
    ['2018-03-03',200000000, "Abu-Abu", 41513],
  ];

  getCoords () {
    var axis = [];
    datas.forEach((element) {
      axis.add([element[0],element[1]]);
    });

    return axis;
  }
}
