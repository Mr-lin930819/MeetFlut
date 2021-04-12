import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tt/thread_num_response.dart';

class ThreadNumBloc extends BlocBase<ThreadNumData> {
  Timer? _refreshTimer;
  DateTime _timeStart;
  DateTime _timeEnd;
  int _step = 72;

  ThreadNumBloc({ThreadNumData? state, DateTime? timeStart, DateTime? timeEnd})
      : this._timeEnd = timeEnd ?? DateTime.now(),
        this._timeStart =
            timeStart ?? DateTime.now().subtract(Duration(hours: 6)),
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
    final result = await Dio(BaseOptions(headers: {
      "Authorization": "Basic dmlld2VyOnhIb3d1TklCbUc5cExMQ3hXMTEx"
    })).get(
      "https://spmmon.51zcm.cc/api/datasources/proxy/1/api/v1/query_range?query=sum%20by%20(node)%20(kubelet_running_container_count)"
      "&start=${_timeStart.millisecondsSinceEpoch / 1000}&end=${_timeEnd.millisecondsSinceEpoch / 1000}&step=${_step}",
    );
    emit(ThreadNumResponse.fromJson(result.data).data ?? ThreadNumData());
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
