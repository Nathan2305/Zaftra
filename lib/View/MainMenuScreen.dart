import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_login/Utils/DataSource.dart';

void main(){
  runApp(MainMenuScreen());
}

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: DataSource.secondaryColor,
            title: Text('Menú Principal'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
