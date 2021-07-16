import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meet_flut/app_prefs.dart';
import 'package:meet_flut/di/di.dart';
import 'package:meet_flut/entry/video/video_first_guide.dart';
import 'package:meet_flut/entry/video/video_main.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      builder: (_, showVideoGuide) {
        return showVideoGuide.data == true ? VideoFirstGuide() : VideoMain();
      },
      future: getIt<AppPrefs>().showVideoGuide(),
    );
  }
}
