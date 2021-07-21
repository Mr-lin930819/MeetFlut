import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 轮播图
///
class PageBanner extends StatefulWidget {
  final List<Widget> pages;

  //循环轮播
  final bool scrollCircle;

  PageBanner(this.pages, {this.scrollCircle = false});

  @override
  State<StatefulWidget> createState() => _PageBannerState();
}

class _PageBannerState extends State<PageBanner> {
  int _curPageIndex = 0;
  late PageController _controller;
  late List<Widget> _indicatorPages;
  late List<Widget> _scrollPages;

  bool get _enableScrollCircle =>
      widget.pages.length >= 2 && widget.scrollCircle;

  @override
  void initState() {
    super.initState();
    _indicatorPages = widget.pages;
    _scrollPages = _indicatorPages;
    if (_enableScrollCircle) {
      Widget first = _indicatorPages[0];
      Widget last = _indicatorPages[_indicatorPages.length - 1];
      _scrollPages = [last, first]..insertAll(1, _indicatorPages);
    }
    _controller = PageController(initialPage: _enableScrollCircle ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _controller,
          children: _scrollPages,
          onPageChanged: _enableScrollCircle
              ? _onCircleScrollPage
              : (index) {
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
              children: _indicatorPages.map((page) {
                final selected = _indicatorPages.indexOf(page) == _curPageIndex;
                return TabPageSelectorIndicator(
                    backgroundColor:
                        selected ? Colors.white : Colors.white.withOpacity(0.5),
                    borderColor: selected ? Colors.white : Colors.blue,
                    size: 12);
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  //循环轮播时的操作
  _onCircleScrollPage(int index) async {
    int logicIndex = index;
    if (index == _scrollPages.length - 1) {
      await Future.delayed(Duration(milliseconds: 400));
      logicIndex = 0;
      _controller.jumpToPage(1);
    } else if (index == 0) {
      await Future.delayed(Duration(milliseconds: 400));
      logicIndex = _indicatorPages.length - 1;
      _controller.jumpToPage(_scrollPages.length - 2);
    } else {
      logicIndex = index - 1;
    }
    setState(() {
      _curPageIndex = logicIndex;
    });
  }
}
