import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meet_flut/gen/assets.gen.dart';

class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int _curPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          children: [
            Assets.images.guide1.image(fit: BoxFit.fill),
            Assets.images.guide2.image(fit: BoxFit.fill),
            Assets.images.guide3.image(fit: BoxFit.fill),
          ],
          onPageChanged: (index) {
            setState(() {
              _curPageIndex = index;
            });
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [0, 1, 2].map((e) => TabPageSelectorIndicator(
                  backgroundColor: e == _curPageIndex ? Colors.white : Colors.white.withOpacity(0.5),
                  borderColor: e == _curPageIndex ? Colors.white : Colors.blue,
                  size: 16)).toList(),
            ),
          ),
        )
      ],
    );
  }

}
