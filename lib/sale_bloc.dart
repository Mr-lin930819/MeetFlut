import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tt/thread_num_response.dart';

class ThreadNumBloc extends BlocBase<ThreadNumData> {
  Timer? _refreshTimer;
  DateTime _timeStart;
  DateTime _timeEnd;
  int _step = 72;
  String _baseUrl;
  String? _combineBaseUrl;
  Dio _dio = Dio(BaseOptions(headers: {
    "Authorization": "Basic dmlld2VyOnhIb3d1TklCbUc5cExMQ3hXMTEx"
  }));

  ThreadNumBloc(
      {ThreadNumData? state,
      DateTime? timeStart,
      DateTime? timeEnd,
      required String baseUrl,
      String? combineBaseUrl})
      : this._timeEnd = timeEnd ?? DateTime.now(),
        this._timeStart =
            timeStart ?? DateTime.now().subtract(Duration(hours: 6)),
        this._baseUrl = baseUrl,
        this._combineBaseUrl = combineBaseUrl,
        super(state ?? ThreadNumData()) {
    this._step = timeInterval.inHours * 12;
    refresh();
    _refreshTimer = Timer.periodic(Duration(seconds: 10), (timer) => refresh());
  }

  int get step => _step;

  Duration get timeInterval => _timeEnd.difference(_timeStart);

  void refresh() async {
    emit(ThreadNumData()
      ..loading = true
      ..resultType = state.resultType
      ..result = state.result);
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
      ThreadNumResponse result = results
          .map((e) => ThreadNumResponse.fromJson(e.data))
          .fold(ThreadNumResponse()..data = (ThreadNumData()..loading = false..result = []),
              (previousValue, element) {
        previousValue.status = element.status;
        previousValue.data?..result?.addAll(element.data?.result ?? []);
        return previousValue;
      });
      emit(result.data ?? ThreadNumData());
    } on DioError {
      emit(ThreadNumData()
        ..loading = false
        ..resultType = state.resultType
        ..result = state.result);
    }
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
