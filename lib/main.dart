import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meet_flut/di/di.dart';
import 'package:meet_flut/entry/video/video_common_channel.dart';
import 'package:meet_flut/entry/video/video_first_guide.dart';
import 'package:meet_flut/entry/video/video_main.dart';
import 'package:meet_flut/named_routes.dart';
import 'package:meet_flut/pages/code_lab_page.dart';
import 'package:meet_flut/pages/photo_page.dart';
import 'package:meet_flut/pages/video_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    final routes = {
      NamedRoutes.SALE: (_, {args}) => SalePage(),
      NamedRoutes.PHOTO: (_, {args}) => PhotoPage(),
      NamedRoutes.CHARTS: (_, {args}) => ChartsPage(),
      NamedRoutes.CODE: (_, {args}) => CodeLabPage(),
      NamedRoutes.VIDEO: (_, {args}) => VideoPage(),
      NamedRoutes.VIDEO_FIRST_GUIDE: (_, {args}) => VideoFirstGuide(),
      NamedRoutes.VIDEO_MAIN: (_, {args}) => VideoMain(),
      NamedRoutes.VIDEO_COMMON_CHANNEL: (_, {args}) =>
          VideoCommonChannel(args['channel']),
    };
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
      localizationsDelegates: [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("zh"),
      ],
      onGenerateRoute: (settings) {
        // 获取声明的路由页面函数
        var pageBuilder = routes[settings.name];
        if (pageBuilder != null) {
          if (settings.arguments != null) {
            return MaterialPageRoute(
                builder: (context) =>
                    pageBuilder(context, args: settings.arguments));
          } else {
            return MaterialPageRoute(
                builder: (context) => pageBuilder(context));
          }
        }
        return MaterialPageRoute(builder: (context) => _HomePage());
      },
      // home: MyHomePage(title: "相册"),
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DecoratedBox(
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
      );
}

List<Menu> _menus = [
  Menu(Icons.shop, "Demo", NamedRoutes.SALE),
  Menu(Icons.photo, "Demo2", NamedRoutes.PHOTO),
  Menu(Icons.code, "CodeLab", NamedRoutes.CODE),
  Menu(Icons.videocam, "视频", NamedRoutes.VIDEO),
  Menu(Icons.show_chart, "图表", NamedRoutes.CHARTS),
];

class Menu {
  IconData icon;
  String name;
  String pageName;
  Map<String, dynamic>? args;

  Menu(this.icon, this.name, this.pageName, {this.args});
}
