// @dart=2.9

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:RestaurantAdmin/Presenter/PresenterMainMenuMVP.dart';
import 'package:animate_do/animate_do.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:sizer/sizer.dart';
import 'package:RestaurantAdmin/Utils/Methods.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceMainMenuMVP.dart';
import 'dart:ui' as ui;

import '../../../main.dart';
import 'LoginScreen.dart';
import 'MiPersonalListScreen.dart';
import 'MisProductos.dart';

class MainMenuScreen extends StatefulWidget {
  final objectId;

  MainMenuScreen(this.objectId);

  _MainMenuScreen createState() => _MainMenuScreen(objectId);
}

class _MainMenuScreen extends State<MainMenuScreen>
    implements interfaceMainMenuMVP {
  String objectId;

  _MainMenuScreen(this.objectId);

  String _businessName = "";
  PresenterMainMenuMVP presenterMainMenuMVP;

  @override
  void initState() {
    // TODO: implement initState
    presenterMainMenuMVP = PresenterMainMenuMVP(this);
    presenterMainMenuMVP.requestModelShowFields(objectId);
    super.initState();
  }

  final listOptions = {'Mi personal', 'Platos', 'Reporte de consumos'};
  final listOptionsImage = {
    'assets/waitress.png',
    'assets/food_drinks.png',
    'assets/report.png'
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                showLogOutOption(context);
              },
              icon: Icon(Icons.logout),
              tooltip: 'Cerrar sesión',
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              width: 100.w,
              height: 35.h,
              child: CustomPaint(
                painter: PainterTitle(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.w, top: 4.h),
                      child: Text(
                        _businessName,
                        style: TextStyle(fontSize: 22.sp, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text('Ventas',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white)),
                              Text('1026',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text('Personal',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white)),
                              Text('1024',
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.white))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FadeInLeft(
                            delay: Duration(milliseconds: 50),
                            child: GestureDetector(
                              onTap: () {
                                Methods.startNewRoute(
                                    context, PersonalScreenState());
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                elevation: 10,
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        gradient: LinearGradient(
                                            colors: [
                                              DataSource.primaryColorPersonal,
                                              DataSource.secondaryColorPersonal
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.centerRight)),
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              listOptionsImage.elementAt(0)),
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
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                            )),
                        FadeInRight(
                            delay: Duration(milliseconds: 50),
                            child: GestureDetector(
                              onTap: () {
                                Methods.startNewRoute(context, MisProductos());
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  elevation: 10,
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          gradient: LinearGradient(
                                              colors: [
                                               DataSource.primaryColorPlatos,
                                                DataSource.secondaryColorPlatos
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.centerRight)),
                                      child: Column(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                listOptionsImage.elementAt(1)),
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
                                            listOptions.elementAt(1).toString(),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ))),
                            )),
                      ],
                    ),
                    FadeInUp(
                      delay: Duration(milliseconds: 50),
                      child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(
                                    colors: [
                                      DataSource.primaryColorReportes,
                                      DataSource.secondaryColorReportes
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerRight)),
                            child: Column(
                              children: [
                                Image(
                                  image:
                                      AssetImage(listOptionsImage.elementAt(2)),
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
                                  listOptions.elementAt(2).toString(),
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  void notifySuccessfulLogOut() {
    // TODO: implement notifySuccessfulLogOut
  }

  @override
  void notifyViewShowFields(String businessName) {
    setState(() {
      _businessName = businessName;
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
}

class PainterTitle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(size.width * 0.00, size.height * 0.50),
        Offset(size.width * 1.00, size.height * 0.50),
        [DataSource.primaryColor, DataSource.secondaryColor],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.lineTo(0, size.height * 0.7600000);
    path0.quadraticBezierTo(size.width * 0.5892857, size.height * 0.9883333,
        size.width * 0.7882143, size.height);
    path0.quadraticBezierTo(size.width * 0.8796429, size.height * 0.9675000,
        size.width * 0.9985714, size.height * 0.7600000);
    path0.lineTo(size.width, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
