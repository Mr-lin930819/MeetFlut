import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meet_flut/pages/code_lab_page.dart';
import 'package:meet_flut/pages/photo_page.dart';
import 'package:meet_flut/pages/video_page.dart';

import 'sale.dart';
import 'package:meet_flut/charts_page.dart';

void main() {
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
                onTap: () => _onMenuClick(context, menu.menuTag),
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

  _onMenuClick(BuildContext context, int menuTag) {
    final Widget page;
    switch (menuTag) {
      case _MENU_SALE:
        page = SalePage();
        break;
      case _MENU_PHOTO:
        page = PhotoPage();
        break;
      case _MENU_VIDEO:
        page = VideoPage();
        break;
      case _MENU_CHARTS:
        page = ChartsPage();
        break;
      case _MENU_CODE:
        page = CodeLabPage();
        break;
      default:
        page = SalePage();
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}

const int _MENU_SALE = 0;
const int _MENU_PHOTO = 1;
const int _MENU_CODE = 2;
const int _MENU_VIDEO = 3;
const int _MENU_CHARTS = 4;

List<_Menu> _menus = [
  _Menu(Icons.shop, "Demo", _MENU_SALE),
  _Menu(Icons.photo, "Demo2", _MENU_PHOTO),
  _Menu(Icons.code, "CodeLab", _MENU_CODE),
  _Menu(Icons.videocam, "视频", _MENU_VIDEO),
  _Menu(Icons.show_chart, "图表", _MENU_CHARTS),
];

class _Menu {
  IconData icon;
  String name;
  int menuTag;

  _Menu(this.icon, this.name, this.menuTag);
}
