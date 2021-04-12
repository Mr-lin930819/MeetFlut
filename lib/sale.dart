import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tt/gen/assets.gen.dart';
import 'package:tt/sale_bloc.dart';
import 'package:tt/thread_num_response.dart';
import 'package:tt/time_bar.dart';

class SalePage extends StatelessWidget {
  final _threadNumBloc = ThreadNumBloc();

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
              ]
                ..addAll(createMenuActions()))),
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
                    Expanded(flex: 2, child: buildSaleRight(_threadNumBloc))
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
      margin: EdgeInsets.only(top: MediaQuery
          .of(context)
          .padding
          .top),
      padding: EdgeInsets.all(10),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Builder(
              builder: (innerContext) =>
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () => Scaffold.of(innerContext).openDrawer(),
                  ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "百斯贝测试",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text("  "),
              Text(
                "操作员：郭靖",
                style: pageTextStyle,
              ),
              Text("  "),
              TimeBar()
            ]),
          ),
          Spacer()
        ],
      ));
}

Widget buildChart(ThreadNumBloc threadNumBloc) =>
    BlocBuilder<ThreadNumBloc, ThreadNumData?>(
      builder: (context, threadNumData) {
        final colors = [
          Colors.blue,
          Colors.greenAccent,
          Colors.orange,
          Colors.deepPurple
        ];
        final metricResults = threadNumData?.result ?? [];
        final lineBars = metricResults.map(
              (chartData) {
            Color color =
            colors[metricResults.indexOf(chartData) % colors.length];
            return LineChartBarData(
                spots: chartData?.values
                    ?.map((e) =>
                    FlSpot(e ? [0] as double, double.parse(e ? [1] ?? "")))
                    .toList(),
                colors: [color],
                barWidth: 1.0,
                belowBarData:
                BarAreaData(show: true, colors: [color.withOpacity(0.15)]),
                dotData: FlDotData(show: false));
          },
        ).toList();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "进程数",
                      textAlign: TextAlign.center,
                      style: pageTextStyle,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Visibility(
                        visible: threadNumData?.loading == true,
                        child: CircularProgressIndicator()),
                  )
                ],
              ),
            ),
            Expanded(
              child: LineChart(LineChartData(
                  lineBarsData: lineBars,
                  gridData: FlGridData(
                      verticalInterval: 5, horizontalInterval: 5, show: true),
                  titlesData: FlTitlesData(
                      leftTitles: SideTitles(
                          showTitles: true,
                          interval: 5,
                          getTextStyles: (index) =>
                              TextStyle(color: Colors.white)),
                      bottomTitles: SideTitles(
                          showTitles: true,
                          interval: threadNumBloc.step * 50,
                          getTextStyles: (value) =>
                              TextStyle(color: Colors.white),
                          getTitles: (value) =>
                              (threadNumBloc.timeInterval.inHours > 24
                                  ? DateFormat("MM-dd")
                                  : DateFormat("HH:mm")).format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      value * 1000 as int)))),
                  lineTouchData: LineTouchData(
                      getTouchedSpotIndicator: (spot, d) =>
                      [
                        TouchedSpotIndicatorData(
                            FlLine(strokeWidth: 0), FlDotData())
                      ]),
                  maxY: 80)),
            ),
          ],
        );
      },
      bloc: threadNumBloc,
    );

Widget buildSaleRight(ThreadNumBloc threadNumBloc) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              buildChart(threadNumBloc) /*GridView.count(
          crossAxisCount: 6,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          childAspectRatio: 1.6,
          children: List.filled(20, 0)
              .map((e) => Container(
                    color: sampleItemColor,
                  ))
              .toList(),
        ),*/
          )),
      Container(
        height: 36,
        color: sampleItemColor,
      ),
      SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (context, index) =>
                Center(
                  child: Container(
                    width: 108,
                    height: 80,
                    decoration: BoxDecoration(
                        color: sampleItemColor,
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                ),
            separatorBuilder: (context, index) =>
                VerticalDivider(
                  color: Colors.transparent,
                ),
            itemCount: 10,
            scrollDirection: Axis.horizontal,
          ),
        ),
      )
    ],
  );
}

Widget buildSaleLeft() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(border: Border.all(color: Colors.white)),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: sampleItemColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          height: 60.0,
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    ListTile(
                      title: Container(height: 48, color: sampleItemColor),
                      leading: Container(
                        height: 42,
                        width: 42,
                        color: sampleItemColor,
                      ),
                    ),
                itemCount: 15,
              ),
            )),
        Container(
          color: sampleItemColor,
          height: 72.0,
        )
      ],
    ),
  );
}

Widget buildImage() {
  return Assets.images.dsc02271.image(
    height: 240.0,
    fit: BoxFit.cover,
  );
}

List<Widget> createMenuActions() =>
    ["测试", "测试1", "测试2", "第四项", "第5项"]
        .map((e) =>
        ListTile(
          title: Text(
            e,
            style: menuTextStyle,
          ),
          onTap: () => Fluttertoast.showToast(msg: e),
        ))
        .toList();

final pageTextStyle = TextStyle(color: Colors.white);

final menuTextStyle = TextStyle(color: Colors.grey);

final sampleItemColor = Colors.white.withOpacity(0.3);
