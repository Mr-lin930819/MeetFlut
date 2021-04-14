import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gen/assets.gen.dart';
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
      home: PageView(
        children: [
          ChartsPage(),
          SalePage()
        ],
      ),
    );
  }
}

class PhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        buildImage(),
        buildTitle(context),
        buildButtons(context),
        buildText()
      ],
    );
  }

  Widget buildImage() {
    return Assets.images.dsc02271.image(
      height: 240.0,
      fit: BoxFit.cover
    );
  }

  Widget buildTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Oeschinen Lake Campground"),
                Text("Kandersteg, Switzerland")
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text("999+")
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(context, Icons.call, 'CALL'),
          buildButtonColumn(context, Icons.near_me, 'ROUTE'),
          buildButtonColumn(context, Icons.share, 'SHARE'),
        ],
      ),
    );
  }

  Widget buildText() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );
  }

  Column buildButtonColumn(BuildContext context, IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Material(
      // appBar: PreferredSize(
      //     child: AppBar(
      //       // Here we take the value from the MyHomePage object that was created by
      //       // the App.build method, and use it to set our appbar title.
      //       title: Text(widget.title, style: TextStyle(color: Colors.white)),
      //     ),
      //     preferredSize: Size.fromHeight(0)),
      child: PhotoPage(),
    );
  }

  void showDlg(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("无"),
        actions: <Widget>[
          TextButton(
            child: Text("好的", style: TextStyle(color: Colors.blueGrey)),
            onPressed: () {},
          ),
          TextButton(
            child: Text("不了", style: TextStyle(color: Colors.blueGrey)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  RandomWords({this.title});
  final String? title;
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(
              child: Text(widget.title ?? "",
                  style: TextStyle(color: Colors.lightBlue))),
          actions: <Widget>[
            IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
          ]),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
