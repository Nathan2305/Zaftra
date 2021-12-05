//@dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_login/Utils/DataSource.dart';

List<String> items;

void main() {
  runApp(MiPersonalScreen());
}

class MiPersonalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: DataSource.primaryColor,
          title: Text('Mi personal'),
        ),
        body: MobileLayoutMiPersonal(),
      ),
    );
  }
}

class MobileLayoutMiPersonal extends StatefulWidget {
  StateMiPersonal createState() => StateMiPersonal();
}

class StateMiPersonal extends State<MobileLayoutMiPersonal> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    items = List<String>.generate(10000, (i) => 'Item $i');
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
        );
      },
    );
  }
}
