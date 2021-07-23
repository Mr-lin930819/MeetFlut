import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet_flut/components/charts/apm_chart_bloc.dart';
import 'package:meet_flut/entities/apm_charts_data.dart';

typedef ChartBuilder = Widget Function(
    BuildContext context, List<Color>, List<MetricResult?>, YMapper, ApmChartBloc);
typedef YMapper = double Function(double);

class ApmLineChart extends StatelessWidget {
  final ApmChartBloc chartsBloc;
  final String? title;
  final YMapper? yMapper;
  final ChartBuilder childChartBuilder;

  ApmLineChart(this.chartsBloc,
      {required this.childChartBuilder, this.title, this.yMapper});

  ApmLineChart.useFlChart(this.chartsBloc, {this.title, this.yMapper})
      : this.childChartBuilder = _flChildChart;

  @override
  Widget build(BuildContext context) => BlocBuilder<ApmChartBloc, ApmChartState>(
        builder: (context, apmChartState) {
          final _chartTextStyle = TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey);
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
          final metricResults = apmChartState.chartsData?.result ?? [];
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
                          visible: apmChartState is ApmChartLoading,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: childChartBuilder(context, colors, metricResults,
                    yMapper ?? defaultYMapper, chartsBloc),
              ),
            ],
          );
        },
        bloc: chartsBloc,
      );

  double defaultYMapper(double value) => value;
}

ChartBuilder _flChildChart = (context, colors, metricResults, yMapper, chartsBloc) {
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
  final chartTextStyle = TextStyle(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.grey);
  final textScale = MediaQuery.of(context).textScaleFactor;
  return LineChart(
    LineChartData(
      lineBarsData: lineBars,
      gridData:
          FlGridData(verticalInterval: 5, horizontalInterval: 5, show: true),
      titlesData: FlTitlesData(
          leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (index) => chartTextStyle.copyWith(fontSize: 12 / textScale)),
          bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              interval: chartsBloc.step * 50,
              getTextStyles: (value) => chartTextStyle.copyWith(fontSize: 12 / textScale),
              getTitles: (value) => chartsBloc.formatDateTime(value))),
      lineTouchData: LineTouchData(
          getTouchedSpotIndicator: (spot, d) =>
              [TouchedSpotIndicatorData(FlLine(strokeWidth: 0), FlDotData())]),
    ),
    swapAnimationDuration: Duration.zero,
  );
};
