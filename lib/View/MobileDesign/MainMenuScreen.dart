import 'dart:async';
import 'dart:ui';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:test_login/Presenter/PresenterMainMenuMVP.dart';
import 'package:test_login/Utils/Methods.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/View/Interfaces/interfaceMainMenuMVP.dart';
import 'package:test_login/View/MobileDesign/MiPersonalListScreen.dart';
import 'dart:math';

import 'LoginScreen.dart';

void main() {
  runApp(MainMenuAdmin());
}

class MainMenuAdmin extends StatelessWidget implements interfaceMainMenuMVP {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //contextDialogLogOut = context;
    return Sizer(builder: (context, orientation, deviceType) {
      bool isMobile = deviceType == DeviceType.mobile;
      bool isTablet = deviceType == DeviceType.tablet;
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            elevation: 10,
            backgroundColor: DataSource.primaryColor,
            actions: [
              IconButton(
                onPressed: () {
                  showLogOutOption(context);
                },
                icon: Icon(Icons.logout),
                tooltip: 'Cerrar sesión',
              )
            ],
            title: Text(
              'Administrador',
            ),
          ),
          body: MainMenuScreen(),
        ),
      );
    });
  }

  void showLogOutOption(BuildContext contextDialogLogOut) {
    showDialog(
        context: contextDialogLogOut,
        builder: (BuildContext alertDialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            //this right here
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('¡¡ Aviso del sistema !!'),
              ],
            ),
            content: Container(
              child: Text("¿Cerrar sesión?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.sp)),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(alertDialogContext, true);
                          //logOutUser(alertDialogContext);
                          Backendless.userService
                              .logout()
                              .then((value) => {
                                    Navigator.pushAndRemoveUntil(
                                        contextDialogLogOut,
                                        Methods.createRoute(MyAppLoginScreen()),
                                        (Route<dynamic> route) => false),
                                  })
                              .catchError((onError) {
                            PlatformException exception = onError;
                            print('Error logging out..' + exception.toString());
                            //String msgError = 'Error cerrando sesión de usuario:" $exception';
                          });
                        },
                        child: Text("Aceptar",
                            textScaleFactor: 1.25,
                            style:
                                TextStyle(color: DataSource.secondaryColor))),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(alertDialogContext, true);
                          },
                          child: Text("Cancelar",
                              textScaleFactor: 1.25,
                              style: TextStyle(
                                  color: DataSource.secondaryColor)))),
                ],
              )
            ],
            elevation: 24.0,
          );
        });
  }

  @override
  void notifySuccessfulLogOut() {
    // TODO: implement notifySuccessfulLogOut
    /*Navigator.pushAndRemoveUntil(
        contextDialogLogOut!,
        AnimationSource.createRoute(MyAppLoginScreen()),
            (Route<dynamic> route) => false);*/
  }
}

class MainMenuScreen extends StatefulWidget {
  StateMainMenuScreen createState() => StateMainMenuScreen();
}

class StateMainMenuScreen extends State<MainMenuScreen>
    with SingleTickerProviderStateMixin {
  Timer? timer;
  double verticalDrag = -90;
  final listOptions = {
    'Mi personal',
    'Platos y bebidas',
    'Reporte de consumos'
  };
  final listOptionsImage = {
    'assets/waitress.png',
    'assets/food_drinks.png',
    'assets/report.png'
  };

  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      //each second
      if (verticalDrag == 0) {
        timer.cancel();
      } else {
        setState(() {
          verticalDrag = verticalDrag + 10;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Container(
            height: 80.h,
            //width: 80.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateX(verticalDrag / 180 * pi),
                  child: GestureDetector(
                    onTap: () {
                      Methods.startNewRoute(context, MiPersonalScreen());
                    },
                    child: Container(
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
                          border: Border.all(
                              color: DataSource.primaryColor, width: 3)),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(listOptionsImage.elementAt(0)),
                            width: 20.w,
                            height: 20.w,
                          ),
                          Container(
                            width: 25.w,
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                          Text(
                            listOptions.elementAt(0).toString(),
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateX(verticalDrag / 180 * pi),
                  child: GestureDetector(
                    onTap: () {
                      //startNewRoute(context,MiPersonalScreen());
                    },
                    child: Container(
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
                          border: Border.all(
                              color: DataSource.primaryColor, width: 3)),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(listOptionsImage.elementAt(1)),
                            width: 20.w,
                            height: 20.w,
                          ),
                          Container(
                            width: 35.w,
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                          Text(
                            listOptions.elementAt(1).toString(),
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateX(verticalDrag / 180 * pi),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
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
                        border: Border.all(
                            color: DataSource.primaryColor, width: 3)),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(listOptionsImage.elementAt(2)),
                          width: 20.w,
                          height: 20.w,
                        ),
                        Container(
                          width: 45.w,
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                        Text(
                          listOptions.elementAt(2).toString(),
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
