import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meet_flut/di/di.dart';
import 'package:meet_flut/entry/video/video_first_guide.dart';
import 'package:meet_flut/entry/video/video_main.dart';
import 'package:meet_flut/named_routes.dart';
import 'package:meet_flut/pages/code_lab_page.dart';
import 'package:meet_flut/pages/photo_page.dart';
import 'package:meet_flut/pages/video_page.dart';

import 'sale.dart';
import 'package:meet_flut/charts_page.dart';

void main() async {
  configureDependencies();
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void setBarStatus(bool isDarkIcon,
        {Color color: Colors.transparent}) async {
      if (Platform.isAndroid) {
        if (isDarkIcon) {
          SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
              statusBarColor: color, statusBarIconBrightness: Brightness.dark);
          SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
        } else {
          SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
              statusBarColor: color, statusBarIconBrightness: Brightness.light);
          SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
        }
      }
    }

    setBarStatus(false);
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        NamedRoutes.SALE: (_) => SalePage(),
        NamedRoutes.PHOTO: (_) => PhotoPage(),
        NamedRoutes.CHARTS: (_) => ChartsPage(),
        NamedRoutes.CODE: (_) => CodeLabPage(),
        NamedRoutes.VIDEO: (_) => VideoPage(),
        NamedRoutes.VIDEO_FIRST_GUIDE: (_) => VideoFirstGuide(),
        NamedRoutes.VIDEO_MAIN: (_) => VideoMain(),
      },
      // home: MyHomePage(title: "相册"),
      home: DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: _menus.length,
            itemBuilder: (context, index) {
              final menu = _menus[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, menu.pageName),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        menu.icon,
                        color: Colors.white,
                        size: 72,
                      ),
                      Text(
                        menu.name,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

List<_Menu> _menus = [
  _Menu(Icons.shop, "Demo", NamedRoutes.SALE),
  _Menu(Icons.photo, "Demo2", NamedRoutes.PHOTO),
  _Menu(Icons.code, "CodeLab", NamedRoutes.CODE),
  _Menu(Icons.videocam, "视频", NamedRoutes.VIDEO),
  _Menu(Icons.show_chart, "图表", NamedRoutes.CHARTS),
];

class _Menu {
  IconData icon;
  String name;
  String pageName;

  _Menu(this.icon, this.name, this.pageName);
}
