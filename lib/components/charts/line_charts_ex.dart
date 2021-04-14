import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_flut/components/charts/charts_bloc.dart';
import 'package:meet_flut/components/charts/line_charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

extension ApmLineChartEx on ApmLineChart {
  static Widget useSfChart(ChartsBloc chartsBloc,
      {String? title, YMapper? yMapper}) {
    return ApmLineChart(chartsBloc, title: title, yMapper: yMapper,
        childChartBuilder: (colors, metricResults, yMapper, chartsBloc) {
      final lineBars = metricResults.map(
        (chartData) {
          Color color =
              colors[metricResults.indexOf(chartData) % colors.length];
          return AreaSeries<List<dynamic>?, String?>(
            dataSource: chartData?.values ?? [],
            animationDuration: 0,
            xValueMapper: (data, index) {
              final value = data?[0] ?? 0;
              return chartsBloc.formatDateTime(value);
            },
            borderColor: color,
            borderWidth: 1,
            yValueMapper: (data, index) =>
                yMapper(double.parse(data?[1]?.toString() ?? "")),
            color: color.withOpacity(0.15),
          );
        },
      ).toList();
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: lineBars,
      );
    });
  }
}
