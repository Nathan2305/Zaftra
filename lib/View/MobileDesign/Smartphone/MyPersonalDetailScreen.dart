import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';

class MyPersonalDetailScreen extends StatelessWidget {
  final BackendlessUser userSelected;

  const MyPersonalDetailScreen({Key? key, required this.userSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var fullName = userSelected.getProperty(DataSource.COLUMN_NAME) +
        " " +
        userSelected.getProperty(DataSource.COLUMN_LAST_NAME);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          primary: true,
          //leading: Icon(Icons.arrow_back),
          backgroundColor: DataSource.primaryColor,
          elevation: 10,
          centerTitle: true,
          title: Text(fullName),
        ),
        body: MobileLayout(),
      ),
    );
  }
}

class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Hero(tag: "photo", child: child)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
