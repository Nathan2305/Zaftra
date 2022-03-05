import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceMainMenuMVP.dart';

import '../../Utils/DataSource.dart';
import '../../Utils/Methods.dart';
import 'dart:ui';

var listOptions;
var listOptionsImage;

class MainMenuWeb extends StatefulWidget {
  _MainMenuWeb createState() => _MainMenuWeb();
}

class _MainMenuWeb extends State<MainMenuWeb> implements interfaceMainMenuMVP {
  Timer? timer;
  double verticalDrag = -90;

  @override
  void initState() {
    // TODO: implement initState
    listOptions = {'Mi personal', 'Platos y bebidas', 'Reporte de consumos'};
    listOptionsImage = {
      'assets/waitress.png',
      'assets/food_drinks.png',
      'assets/report.png'
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
          child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: VerticalPanelOptions(),
                width: 25.w,
                height: 100.h,
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                child: Container(
                  color: Colors.red,
                ),
                width: 75.w,
                height: 100.h,
              ),
              flex: 3,
            )
          ],
        ),
      )),
    );
  }

  @override
  void notifySuccessfulLogOut() {
    // TODO: implement notifySuccessfulLogOut
  }
}

class VerticalPanelOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          width: 20.w,
          height: 30.h,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: DataSource.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(-10, 10),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: DataSource.primaryColor, width: 3)),
          child: Column(
            children: [
              Image(
                image: AssetImage(listOptionsImage.elementAt(0)),
                width: 20.h,
                height: 20.h,
              ),
              Container(
                width: 15.w,
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              Text(
                listOptions.elementAt(0).toString(),
                style: TextStyle(fontSize: 4.sp, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 20.w,
          height: 30.h,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: DataSource.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(-10, 10),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: DataSource.primaryColor, width: 3)),
          child: Column(
            children: [
              Image(
                image: AssetImage(listOptionsImage.elementAt(1)),
                width: 20.h,
                height: 20.h,
              ),
              Container(
                width: 15.w,
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              Text(
                listOptions.elementAt(1).toString(),
                style: TextStyle(fontSize: 4.sp, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 20.w,
          height: 30.h,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: DataSource.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(-10, 10),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: DataSource.primaryColor, width: 3)),
          child: Column(
            children: [
              Image(
                image: AssetImage(listOptionsImage.elementAt(2)),
                width: 20.h,
                height: 20.h,
              ),
              Container(
                width: 15.w,
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              Text(
                listOptions.elementAt(2).toString(),
                style: TextStyle(fontSize: 4.sp, color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
