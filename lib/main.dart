// @dart=2.9
import 'dart:async';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/LoginScreen.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/MainMenuScreen.dart';
import 'package:RestaurantAdmin/View/WebDesign/LoginLayoutWeb.dart';
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
  static BackendlessUser currentUser;

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
  bool changeAsset = false;
  int positionAssetChosen = 0;
  bool userAlreadyLoggedIn = false;
  bool finishValidateUser = false;
  final _animationDuration = Duration(milliseconds: 130);
  Timer _timer;
  var assetVariable;
  bool firstImage = true;
  double verticalDrag = 90;
  double horizontalDrag = 90;
  Timer _timer2;
  var assetArray = {
    'assets/anticucho.png',
    'assets/caldo_gallina.png',
    'assets/salchipapa.jpg',
    'assets/lomo.png',
    'assets/ceviche.jpg'
  };

  void _changeAsset() {
    if (!finishValidateUser) {
      setState(() {
        verticalDrag = verticalDrag - 18;
        if (verticalDrag % 180 == 0) {
          if (firstImage) {
            firstImage = false;
          }
          assetVariable = setOtherAsset();
        }
      });
    } else {
      _timer.cancel();
      _timer2 = Timer.periodic(
          Duration(milliseconds: 70), (timer) => initLoginOrMainMenu());
    }
  }

  Future<void> validateUserLoggedIn() async {
    String msgError;
    Map<dynamic, dynamic> mapUser;
    String objectId =
        await Backendless.userService.loggedInUser().catchError((onError) {
      PlatformException exception = onError;
      finishValidateUser = true;
      msgError = 'Error obteniendo sesión de usuario:" $exception';
    });
    if (objectId != null && objectId.isNotEmpty) {
      mapUser = await Backendless.data
          .of("Users")
          .findById(objectId)
          .catchError((onError) {
        PlatformException exception = onError;
        msgError = 'Error obteniendo sesión de usuario:" $exception';
      });
      if (mapUser != null) {
        MyAppMain.currentUser = BackendlessUser.fromJson(mapUser);
        userAlreadyLoggedIn = true;
      }
    }
    finishValidateUser = true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Backendless.initApp(
        applicationId: "C53D7BF1-EC61-A11B-FF18-31BAED0CB500",
        androidApiKey: "DB303CEE-4604-43D7-8FE6-D8ACA6B45FF5",
        iosApiKey: "C8E9E135-C284-49C9-BFFC-CC95F85705A1");
    Future.delayed(Duration(seconds: 2)).then((value) => {
          _timer =
              Timer.periodic(_animationDuration, (timer) => _changeAsset()),
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _timer2.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: !finishValidateUser
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..rotateY(verticalDrag / 180 * pi),
                              child: Container(
                                width: 20.w,
                                height: 20.w,
                                color: Colors.white,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    // border:  Border.all(width: 1.0, color: Colors.red),
                    //borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage(firstImage
                            ? assetArray.elementAt(0)
                            : assetVariable),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('Cargando...',
                      style: TextStyle(
                          color: DataSource.primaryColor, fontSize: 8.w)),
                )
              ],
            )
          : Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(horizontalDrag / 180 * pi),
              child:
                  !userAlreadyLoggedIn ? MyAppLoginScreen() : MainMenuAdmin()),
    );
  }

  String setOtherAsset() {
    positionAssetChosen++;
    if (positionAssetChosen == assetArray.length) {
      validateUserLoggedIn();
      positionAssetChosen = 0;
    }
    return assetArray.elementAt(positionAssetChosen);
  }

  initLoginOrMainMenu() {
    setState(() {
      horizontalDrag = horizontalDrag - 18;
      if (horizontalDrag == 0) {
        _timer2.cancel();
      }
    });
  }
}
