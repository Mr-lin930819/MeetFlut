import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_flut/components/video/page_banner.dart';
import 'package:meet_flut/gen/assets.gen.dart';
import 'package:meet_flut/main.dart';
import 'package:meet_flut/named_routes.dart';

///视频主页
class VideoMain extends StatelessWidget {
  final List<Menu> _menus = [
    Menu(Icons.tv, "电视剧", NamedRoutes.VIDEO_SHOW),
    Menu(Icons.movie, "电影", NamedRoutes.VIDEO_MOVIE),
    Menu(Icons.child_care, "动漫", NamedRoutes.VIDEO_COMIC),
    Menu(Icons.scanner, "纪录片", NamedRoutes.VIDEO_DOCUMENTARY),
    Menu(Icons.music_note, "音乐", NamedRoutes.VIDEO_MUSIC),
    Menu(Icons.toys, "综艺", NamedRoutes.VIDEO_VARIETY),
    Menu(Icons.live_tv, "直播", NamedRoutes.VIDEO_LIVE),
    Menu(Icons.favorite, "收藏", NamedRoutes.VIDEO_FAVORITE),
    Menu(Icons.history, "历史记录", NamedRoutes.VIDEO_HISTORY),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Text(
                  'Mr.Lin',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
            ListTile(
              leading: Icon(Icons.video_call),
              title: Text('视频'),
            ),
            AboutListTile(
              applicationName: "MeetFlut",
              applicationIcon: Icon(Icons.info),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 240,
            child: PageBanner([
              Assets.images.guide1.image(fit: BoxFit.fitWidth),
              Assets.images.guide2.image(fit: BoxFit.fitWidth),
            ], scrollCircle: true,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildMenuView(context),
            ),
          )
        ],
      ),
    );
  }

  //菜单
  GridView _buildMenuView(BuildContext context) => GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (_, index) {
          final menu = _menus[index];
          return GestureDetector(
            child: Column(
              children: [
                Icon(
                  menu.icon,
                  size: 64,
                  color: Theme.of(context).primaryColor,
                ),
                Text(menu.name)
              ],
            ),
            onTap: () => Navigator.pushNamed(context, menu.pageName),
          );
        },
        itemCount: _menus.length,
      );
}
