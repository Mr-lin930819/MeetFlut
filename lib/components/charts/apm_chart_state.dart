part of 'apm_chart_bloc.dart';

@immutable
abstract class ApmChartState {
  final ApmChartsData? chartsData;

  ApmChartState(this.chartsData);
}

class ApmChartInitial extends ApmChartState {
  ApmChartInitial() : super(ApmChartsData());
}

class ApmChartLoading extends ApmChartState {
  ApmChartLoading(ApmChartsData? currentData) : super(currentData);
}

class ApmChartCompleted extends ApmChartState {
  ApmChartCompleted(ApmChartsData? chartsData) : super(chartsData);
}

class ApmChartError extends ApmChartState {
  ApmChartError(ApmChartsData? chartsData) : super(chartsData);
}
