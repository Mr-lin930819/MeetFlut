part of 'apm_chart_bloc.dart';

@immutable
abstract class ApmChartEvent {}

class ApmChartRefresh extends ApmChartEvent {}