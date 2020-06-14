import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SalePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    var state = _SaleState();
    state.tickTime();
    return state;
  }
}

class _SaleState extends State<SalePage> {
  String _nowTime;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 0x0a, 0x1b, 0x44),
      child: Column(
        children: <Widget>[createTitleBar(), createMain()],
      ),
    );
  }

  tickTime() {
    Timer.periodic(
        Duration(seconds: 1),
        (timer) => {
              setState(() {
                _nowTime = DateTime.now().toLocal().toString();
              })
            });
  }

  Widget createTitleBar() {
    return Container(
        height: 60,
        padding: EdgeInsets.all(10.0),
        color: Colors.blueGrey,
        margin: EdgeInsets.only(top: 26),
        child: Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset('images/ic_table_white.png'),
            Text(
              "百斯贝测试3",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              "操作员：郭靖",
              style: pageTextStyle,
            ),
            Text(_nowTime, style: pageTextStyle)
          ],
        )));
  }
}

Widget createMain() {
  return Expanded(
      child: Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Expanded(flex: 1, child: buildSaleLeft()),
      Expanded(flex: 2, child: buildSaleRight())
    ],
  ));
}

Widget buildSaleRight() {
  return Container(
    alignment: Alignment.center,
    child: Text("右侧", style: pageTextStyle, textAlign: TextAlign.center),
  );
}

Widget buildSaleLeft() {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    child: Text("左侧", style: pageTextStyle, textAlign: TextAlign.center),
  );
}

Widget buildImage() {
  return Image.asset(
    'images/DSC_0227_1.jpg',
    height: 240.0,
    fit: BoxFit.cover,
  );
}

Container createSaleLeftList() {
  return Container(
    width: 100,
    child: ListView(
      children: <Widget>[
        Text(
          "测试",
          style: pageTextStyle,
        )
      ],
    ),
  );
}

final pageTextStyle = TextStyle(color: Colors.white);
