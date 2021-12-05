// @dart=2.9
import 'dart:collection';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_login/View/LoginScreen.dart';
import 'package:test_login/View/MainMenuScreen.dart';

import 'Utils/DataSource.dart';

void main() {
  runApp(MyAppMain());
}

class MyAppMain extends StatefulWidget {
  static BackendlessUser currentUser;

  // This widget is the root of your application.
  @override
  _MyAppMain createState() => _MyAppMain();
}

class _MyAppMain extends State<MyAppMain> with TickerProviderStateMixin {
  bool userAlreadyLoggedIn = false;
  bool finishValidate = false;
  @override
  void initState() {
   Backendless.initApp(
        applicationId: "C53D7BF1-EC61-A11B-FF18-31BAED0CB500",
        androidApiKey: "DB303CEE-4604-43D7-8FE6-D8ACA6B45FF5",
        iosApiKey: "C8E9E135-C284-49C9-BFFC-CC95F85705A1");
    validateUserLoggedIn();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement builds
    return MaterialApp(
      home: Scaffold(
          body: !finishValidate
              ? SpinkitLoadingScreen()
              : userAlreadyLoggedIn
                  ? MainMenuScreen()
                  : MyAppLoginScreen()),
    );
  }

  Future<void> validateUserLoggedIn() async {
    String msgError;
    Map<dynamic, dynamic> mapUser;
    String objectId =
        await Backendless.userService.loggedInUser().catchError((onError) {
      PlatformException exception = onError;
      msgError = 'Error obteniendo sesión de usuario:" $exception';
      setState(() {
        userAlreadyLoggedIn = false;
        finishValidate = true;
      });
      //WORKS LATER HERE....
    });
    if (objectId != null && objectId.isNotEmpty) {
      mapUser = await Backendless.data
          .of("Users")
          .findById(objectId)
          .catchError((onError) {
        PlatformException exception = onError;
        msgError = 'Error obteniendo sesión de usuario:" $exception';
        setState(() {
          userAlreadyLoggedIn = false;
          finishValidate = true;
        });
      });
    } else {
      Future.delayed(
          Duration(seconds: 3),
          () => setState(() {
                userAlreadyLoggedIn = false;
                finishValidate = true;
              }));
    }
    if (mapUser != null) {
      MyAppMain.currentUser = BackendlessUser.fromJson(mapUser);
      Future.delayed(
          Duration(seconds: 3),
          () => setState(() {
                userAlreadyLoggedIn = true;
                finishValidate = true;
              }));
    }
  }
}

class SpinkitLoadingScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitSpinningLines(
                  lineWidth: 3,
                  size: MediaQuery.of(context).size.height * 0.2,
                  color: DataSource.primaryColor,
                  duration:Duration(seconds: 2)),
              Container(
                margin: EdgeInsets.all(25),
                child: Text(
                  'Cargando...',
                  style: TextStyle(color: DataSource.primaryColor, fontSize: 20),
                ),
          ),
        ],
      )),
    );
  }
}
