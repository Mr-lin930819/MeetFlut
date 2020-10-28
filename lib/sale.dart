import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tt/time_bar.dart';

class SalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 0x0a, 0x1b, 0x44),
      child: Column(
        children: <Widget>[
          createTitleBar(),
          Expanded(
            child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(flex: 1, child: buildSaleLeft()),
                  Expanded(flex: 2, child: buildSaleRight())
                ]),
          )
        ],
      ),
    );
  }
}

Widget createTitleBar() {
  return Container(
      constraints: BoxConstraints.expand(height: 60),
      margin: EdgeInsets.only(top: 26),
      padding: EdgeInsets.all(10),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
          Text(
            "百斯贝测试3",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            "操作员：郭靖",
            style: pageTextStyle,
          ),
          TimeBar()
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
    decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    child: ListView(children: createSaleLeftList()),
  );
}

Widget buildImage() {
  return Image.asset(
    'images/DSC_0227_1.jpg',
    height: 240.0,
    fit: BoxFit.cover,
  );
}

List<Widget> createSaleLeftList() => ["测试", "测试1", "测试2", "第四项", "第5项"]
    .map((e) => Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => Fluttertoast.showToast(msg: e),
            child: Text(
              e,
              style: pageTextStyle,
            ),
          ),
        ))
    .toList();

final pageTextStyle = TextStyle(color: Colors.white);
