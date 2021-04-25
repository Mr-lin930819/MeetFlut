import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_flut/components/charts/apm_chart_bloc.dart';
import 'package:meet_flut/components/charts/line_charts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

extension ApmLineChartEx on ApmLineChart {
  static Widget useSfChart(ApmChartBloc chartsBloc,
      {String? title, YMapper? yMapper, bool showLegend = false}) {
    return ApmLineChart(chartsBloc, title: title, yMapper: yMapper,
        childChartBuilder:
            (context, colors, metricResults, yMapper, chartsBloc) {
      final lineBars = metricResults.map(
        (chartData) {
          Color color =
              colors[metricResults.indexOf(chartData) % colors.length];
          return AreaSeries<List<dynamic>?, String?>(
            name: chartData?.metric?.node ?? "",
            dataSource: chartData?.values ?? [],
            animationDuration: 0,
            enableTooltip: true,
            xValueMapper: (data, index) {
              final value = data?[0] ?? 0;
              return chartsBloc.formatDateTime(value);
            },
            borderColor: color,
            borderWidth: 1,
            isVisibleInLegend: true,
            yValueMapper: (data, index) =>
                yMapper(double.parse(data?[1]?.toString() ?? "")),
            color: color.withOpacity(0.15),
            legendIconType: LegendIconType.horizontalLine,
          );
        },
      ).toList();
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            edgeLabelPlacement: EdgeLabelPlacement.shift),
        series: lineBars,
        enableAxisAnimation: false,
        legend: showLegend
            ? Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap)
            : null,
      );
    });
  }
}
