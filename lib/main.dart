// @dart=2.9
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/LoginScreen.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/MainMenuScreen.dart';
import 'package:RestaurantAdmin/View/WebDesign/LoginLayoutWeb.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Utils/DataSource.dart';
import 'View/WebDesign/ValidateUserSession.dart';
import 'main.reflectable.dart';
import 'package:sizer/sizer.dart';
import 'dart:math';

void main() {
  initializeReflectable();

  runApp(MyAppMain());
}

class MyAppMain extends StatelessWidget {
  //static BackendlessUser currentUser;

  @override
  Widget build(BuildContext context) {
    Backendless.initApp(
        applicationId: "C53D7BF1-EC61-A11B-FF18-31BAED0CB500",
        androidApiKey: "DB303CEE-4604-43D7-8FE6-D8ACA6B45FF5",
        iosApiKey: "C8E9E135-C284-49C9-BFFC-CC95F85705A1",
        jsApiKey: "66764F86-1F2A-4973-B40B-99DF2966E19E");
    // TODO: implement builds
    return Sizer(builder: (context, orientation, deviceType) {
      bool isWeb = deviceType == DeviceType.web;
      return MaterialApp(
          home: Scaffold(
        body: isWeb ? ValidateUserSession() : StateMainWidget(),
        backgroundColor: Colors.white,
      ));
    });
  }
}

class StateMainWidget extends StatefulWidget {
  _AnimationWidget createState() => _AnimationWidget();
}

class _AnimationWidget extends State<StateMainWidget>
    with SingleTickerProviderStateMixin {
 Future<String> _objectIdUser;

  @override
  void initState() {
    // TODO: implement initState
    Backendless.initApp(
        applicationId: "C53D7BF1-EC61-A11B-FF18-31BAED0CB500",
        androidApiKey: "DB303CEE-4604-43D7-8FE6-D8ACA6B45FF5",
        iosApiKey: "C8E9E135-C284-49C9-BFFC-CC95F85705A1");
    _objectIdUser=Backendless.userService.loggedInUser();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: _objectIdUser,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasData) {
            String objectId = snapshot.data;
            if (objectId != null && objectId.isNotEmpty) {
              return Container(
                child: MainMenuScreen(objectId),
              );
            } else {
              return Container(
                child: ZoomIn(
                  delay: Duration(seconds: 2),
                  child: MyAppLoginScreen(),
                ),
              );
            }
          } else {
            //error.....
            var data = snapshot.data;
            print('Data obtained ${data}');
            return Container();
          }
        });
  }

}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SpinKitCircle(
      color: Colors.blue,
      size: 15.h,
    );
  }
}
