import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tt/sale_bloc.dart';
import 'package:tt/thread_num_response.dart';

class SfApmLineChart extends StatelessWidget {
  final ThreadNumBloc threadNumBloc;
  final String? title;
  final double Function(double)? yMapper;

  SfApmLineChart(this.threadNumBloc, {this.title, this.yMapper});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ThreadNumBloc, ThreadNumData?>(
        builder: (context, threadNumData) {
          final colors = [
            Color.fromRGBO(0x05, 0xD5, 0x23, 1),
            Color.fromRGBO(0x12, 0x7D, 0xFF, 1),
            Color.fromRGBO(0xFF, 0x6F, 0x6F, 1),
            Color.fromRGBO(0xFF, 0xB5, 0x24, 1),
            Color.fromRGBO(0x05, 0xD5, 0xAC, 1),
            Color.fromRGBO(0x93, 0x32, 0xF2, 1),
            Color.fromRGBO(75, 135, 185, 1),
            Color.fromRGBO(192, 108, 132, 1),
            Color.fromRGBO(246, 114, 128, 1),
            Color.fromRGBO(248, 177, 149, 1),
            Color.fromRGBO(116, 180, 155, 1),
          ];
          final metricResults = threadNumData?.result ?? [];
          final lineBars = metricResults.map(
            (chartData) {
              Color color =
                  colors[metricResults.indexOf(chartData) % colors.length];
              return AreaSeries<List<dynamic>?, String?>(
                dataSource: chartData?.values ?? [],
                animationDuration: 0,
                xValueMapper: (data, index) {
                  final value = data?[0] ?? 0;
                  return (threadNumBloc.timeInterval.inHours > 24
                          ? DateFormat("MM-dd")
                          : DateFormat("HH:mm"))
                      .format(DateTime.fromMillisecondsSinceEpoch(
                          (value * 1000).toInt()));
                },
                borderColor: color,
                borderWidth: 1,
                yValueMapper: (data, index) => (yMapper?? defaultYMapper).call(double.parse(data?[1]?.toString() ?? "")),
                color: color.withOpacity(0.15),
              );
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
                        title ?? "进程数",
                        textAlign: TextAlign.center,
                        style: _chartTextStyle,
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
                  child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: lineBars,
              )),
            ],
          );
        },
        bloc: threadNumBloc,
      );

  double defaultYMapper(double value) => value;
}

final _chartTextStyle = TextStyle(color: Colors.white);
