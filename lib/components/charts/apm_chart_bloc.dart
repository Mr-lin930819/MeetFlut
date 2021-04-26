import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:meet_flut/entities/thread_num_response.dart';
import 'package:meta/meta.dart';

part 'apm_chart_event.dart';

part 'apm_chart_state.dart';

class ApmChartBloc extends Bloc<ApmChartEvent, ApmChartState> {
  Timer? _refreshTimer;
  DateTime _timeStart;
  DateTime _timeEnd;
  int _step = 72;
  String _baseUrl;
  String? _combineBaseUrl;
  Dio _dio = Dio(BaseOptions(headers: {
    "Authorization": "Basic dmlld2VyOnhIb3d1TklCbUc5cExMQ3hXMTEx"
  }));

  ApmChartBloc(
      {ApmChartsData? state,
      DateTime? timeStart,
      DateTime? timeEnd,
      required String baseUrl,
      String? combineBaseUrl})
      : this._timeEnd = timeEnd ?? DateTime.now(),
        this._timeStart =
            timeStart ?? DateTime.now().subtract(Duration(hours: 6)),
        this._baseUrl = baseUrl,
        this._combineBaseUrl = combineBaseUrl,
        super(ApmChartInitial()) {
    this._step = timeInterval.inHours * 12;
    add(ApmChartRefresh());
    _refreshTimer = Timer.periodic(
        Duration(seconds: 100), (timer) => this.add(ApmChartRefresh()));
  }

  int get step => _step;

  Duration get timeInterval => _timeEnd.difference(_timeStart);

  Future<ApmChartState> _refresh() async {
    List<Future> responses = [];
    responses.add(_dio.get(
      _baseUrl +
          "&start=${_timeStart.millisecondsSinceEpoch / 1000}&end=${_timeEnd.millisecondsSinceEpoch / 1000}&step=$_step",
    ));
    if (_combineBaseUrl?.isNotEmpty == true) {
      responses.add(_dio.get(
        (_combineBaseUrl ?? "") +
            "&start=${_timeStart.millisecondsSinceEpoch / 1000}&end=${_timeEnd.millisecondsSinceEpoch / 1000}&step=${_step * 3}",
      ));
    }
    try {
      final results = await Future.wait(responses);
      ChartsResponse result =
          results.map((e) => ChartsResponse.fromJson(e.data)).fold(
              ChartsResponse()
                ..data = (ApmChartsData()
                  ..loading = false
                  ..result = []), (previousValue, element) {
        previousValue.status = element.status;
        previousValue.data?..result?.addAll(element.data?.result ?? []);
        return previousValue;
      });
      return ApmChartCompleted(result.data ?? ApmChartsData());
    } on DioError {
      return ApmChartError(state.chartsData);
    }
  }

  String formatDateTime(double secondsSinceEpoch) =>
      (timeInterval.inHours > 24 ? DateFormat("MM-dd") : DateFormat("HH:mm"))
          .format(DateTime.fromMillisecondsSinceEpoch(
              (secondsSinceEpoch * 1000).toInt()));

  @override
  Stream<ApmChartState> mapEventToState(
    ApmChartEvent event,
  ) async* {
    if (event is ApmChartRefresh) {
      yield ApmChartLoading(state.chartsData);
      yield await _refresh();
    }
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
