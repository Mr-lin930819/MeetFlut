import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TimeBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<TimerBloc, String>(
        builder: (BuildContext context, time) =>
            Text(time, style: TextStyle(color: Colors.white)),
        bloc: TimerBloc(),
      );
}

class TimerBloc extends Cubit<String> {
  Timer? _timer;

  TimerBloc() : super("") {
    tickTime();
  }

  void tickTime() {
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => emit(DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime.now().toLocal())));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
