import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimeBarState();
}

class _TimeBarState extends State<TimeBar> {
  String _nowTime;
  Timer timer;

  @override
  void initState() {
    super.initState();
    tickTime();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_nowTime ?? "", style: TextStyle(color: Colors.white));
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void tickTime() {
    timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => {
              setState(() {
                _nowTime = DateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(DateTime.now().toLocal());
              })
            });
  }
}
