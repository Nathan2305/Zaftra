// @dart=2.9
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:test_login/View/LoginScreen.dart';
import 'package:test_login/View/MainMenuScreen.dart';

AnimationController animationController;
MaterialPageRoute route;
bool isWideScreenWidth = false;

void main() {
  runApp(MyAppMain());
}

class MyAppMain extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppMain createState() => _MyAppMain();
}

class _MyAppMain extends State<MyAppMain> with TickerProviderStateMixin {
  bool userAlreadyLoggedIn = false;
  bool firstBuild = true;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    Backendless.initApp(
        applicationId: "C53D7BF1-EC61-A11B-FF18-31BAED0CB500",
        androidApiKey: "DB303CEE-4604-43D7-8FE6-D8ACA6B45FF5",
        iosApiKey: "C8E9E135-C284-49C9-BFFC-CC95F85705A1");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          body: firstBuild
              ? Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Container(
                      child: Lottie.asset(
                        'assets/loading_icon.json',
                        controller: animationController,
                        onLoaded: (composition) {
                          animationController.forward();
                          animationController.addListener(() {
                            if (animationController.isCompleted) {
                              animationController.repeat();
                              validateUserLoggedIn();
                            }
                          });
                        },
                      ),
                    ),
                  ),
                )
              : userAlreadyLoggedIn
                  ? MainMenuScreen()
                  : LoginScreen()),
    );
  }

  void validateUserLoggedIn() {
    Backendless.userService.getUserToken().then((userToken) {
      if (userToken != null && userToken.isNotEmpty) {
        setState(() {
          firstBuild = false;
          userAlreadyLoggedIn = true;
          // animationController.stop();
        });
      } else {
        firstBuild = false;
        setState(() {
          firstBuild = false;
          animationController.stop();
        });
      }
    }).catchError((onError) {
      // animationController.dispose();
      PlatformException exception = onError;
      print("Error getting user token: " + exception.message);
    });
  }
}
