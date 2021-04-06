import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tt/gen/assets.gen.dart';
import 'package:tt/time_bar.dart';

class SalePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
              children: [
        DrawerHeader(
          child: Center(
            child: Text(
              "侧滑菜单",
              style: pageTextStyle.copyWith(fontSize: 36.0),
            ),
          ),
          decoration: BoxDecoration(color: Colors.blueGrey),
        )
      ]..addAll(createMenuActions()))),
      body: Material(
        color: Color.fromARGB(255, 0x0a, 0x1b, 0x44),
        child: Column(
          children: <Widget>[
            createTitleBar(context),
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
      ),
    );
  }
}

Widget createTitleBar(BuildContext context) {
  return Container(
      constraints: BoxConstraints.expand(height: 60),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.all(10),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Builder(
            builder: (innerContext) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(innerContext).openDrawer(),
            ),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
              text: "百斯贝测试",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            TextSpan(text: "  "),
            TextSpan(
              text: "操作员：郭靖",
              style: pageTextStyle,
            ),
          ])),
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
    child: Center(
      child: Text(
        "左侧",
        style: pageTextStyle,
      ),
    ),
  );
}

Widget buildImage() {
  return Assets.images.dsc02271.image(
    height: 240.0,
    fit: BoxFit.cover,
  );
}

List<Widget> createMenuActions() => ["测试", "测试1", "测试2", "第四项", "第5项"]
    .map((e) => ListTile(
          title: Text(
            e,
            style: menuTextStyle,
          ),
          onTap: () => Fluttertoast.showToast(msg: e),
        ))
    .toList();

final pageTextStyle = TextStyle(color: Colors.white);

final menuTextStyle = TextStyle(color: Colors.grey);
