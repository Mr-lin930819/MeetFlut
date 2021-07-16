import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_flut/app_prefs.dart';
import 'package:meet_flut/di/di.dart';
import 'package:meet_flut/gen/assets.gen.dart';
import 'package:meet_flut/named_routes.dart';

class VideoFirstGuide extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoFirstGuideState();
}

class _VideoFirstGuideState extends State<VideoFirstGuide> {
  int _curPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Image> pages = [
      Assets.images.guide1.image(fit: BoxFit.fill),
      Assets.images.guide2.image(fit: BoxFit.fill),
      Assets.images.guide3.image(fit: BoxFit.fill)
    ];
    return Stack(
      children: [
        PageView(
          children: pages,
          onPageChanged: (index) {
            setState(() {
              _curPageIndex = index;
            });
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Offstage(
                offstage: _curPageIndex != pages.length - 1,
                child: TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "进入应用",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    getIt<AppPrefs>().setShowVideoGuide(false);
                    Navigator.pushReplacementNamed(
                        context, NamedRoutes.VIDEO_MAIN);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pages.map((e) {
                    final selected = pages.indexOf(e) == _curPageIndex;
                    return TabPageSelectorIndicator(
                        backgroundColor: selected
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        borderColor: selected ? Colors.white : Colors.blue,
                        size: 12);
                  }).toList(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
