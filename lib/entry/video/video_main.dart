import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_flut/components/video/page_banner.dart';
import 'package:meet_flut/gen/assets.gen.dart';
import 'package:meet_flut/main.dart';
import 'package:meet_flut/named_routes.dart';

///视频主页
class VideoMain extends StatelessWidget {
  final List<Menu> _menus = [
    Menu(Icons.shop, "Demo", NamedRoutes.SALE),
    Menu(Icons.photo, "Demo2", NamedRoutes.PHOTO),
    Menu(Icons.code, "CodeLab", NamedRoutes.CODE),
    Menu(Icons.videocam, "视频", NamedRoutes.VIDEO),
    Menu(Icons.show_chart, "图表", NamedRoutes.CHARTS),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 240,
            child: PageBanner([
              Assets.images.guide1.image(fit: BoxFit.fitWidth),
              Assets.images.guide2.image(fit: BoxFit.fitWidth),
            ]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildMenuView(),
            ),
          )
        ],
      ),
    );
  }

  //菜单
  GridView _buildMenuView() => GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (_, index) {
          final menu = _menus[index];
          return Column(
            children: [
              Icon(
                menu.icon,
                size: 64,
              ),
              Text(menu.name)
            ],
          );
        },
        itemCount: _menus.length,
      );
}
