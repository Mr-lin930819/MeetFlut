import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_flut/components/codelab/step_demo.dart';

class CodeLabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CodeLab"),
      ),
      body: Column(
        children: [_buildItem(context, "步骤组件", () => StepDemo())],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, Widget toPage()) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      title: Text(title),
      onTap: () => _toPage(context, toPage()),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }

  _toPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
