import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet_flut/components/charts/charts_bloc.dart';
import 'package:meet_flut/entities/thread_num_response.dart';

typedef ChartBuilder = Widget Function(
    List<Color>, List<MetricResult?>, YMapper, ChartsBloc);
typedef YMapper = double Function(double);

class ApmLineChart extends StatelessWidget {
  final ChartsBloc chartsBloc;
  final String? title;
  final YMapper? yMapper;
  final ChartBuilder childChartBuilder;

  ApmLineChart(this.chartsBloc,
      {required this.childChartBuilder, this.title, this.yMapper});

  ApmLineChart.useFlChart(this.chartsBloc, {this.title, this.yMapper})
      : this.childChartBuilder = _flChildChart;

  @override
  Widget build(BuildContext context) => BlocBuilder<ChartsBloc, ApmChartsData?>(
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
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        this.title ?? "进程数",
                        textAlign: TextAlign.center,
                        style: _chartTextStyle.copyWith(fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: Visibility(
                          visible: threadNumData?.loading == true,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: childChartBuilder(colors, metricResults,
                    yMapper ?? defaultYMapper, chartsBloc),
              ),
            ],
          );
        },
        bloc: chartsBloc,
      );

  double defaultYMapper(double value) => value;
}

ChartBuilder _flChildChart = (colors, metricResults, yMapper, chartsBloc) {
  final lineBars = metricResults.map(
    (chartData) {
      Color color = colors[metricResults.indexOf(chartData) % colors.length];
      return LineChartBarData(
          spots: chartData?.values
              ?.map((e) =>
                  FlSpot(e?[0] as double, yMapper(double.parse(e?[1] ?? ""))))
              .toList(),
          colors: [color],
          barWidth: 1.0,
          belowBarData:
              BarAreaData(show: true, colors: [color.withOpacity(0.15)]),
          dotData: FlDotData(show: false));
    },
  ).toList();
  return LineChart(
    LineChartData(
      lineBarsData: lineBars,
      gridData:
          FlGridData(verticalInterval: 5, horizontalInterval: 5, show: true),
      titlesData: FlTitlesData(
          leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (index) => _chartTextStyle.copyWith(fontSize: 6)),
          bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: chartsBloc.step * 50,
              getTextStyles: (value) => _chartTextStyle.copyWith(fontSize: 6),
              checkToShowTitle: (minValue, maxValue, sideTitles, appliedInterval, value) {
                return (maxValue - minValue) % appliedInterval == 0;
              },
              getTitles: (value) => chartsBloc.formatDateTime(value))),
      lineTouchData: LineTouchData(
          getTouchedSpotIndicator: (spot, d) =>
              [TouchedSpotIndicatorData(FlLine(strokeWidth: 0), FlDotData())]),
    ),
    swapAnimationDuration: Duration.zero,
  );
};

final _chartTextStyle = TextStyle(color: Colors.white);