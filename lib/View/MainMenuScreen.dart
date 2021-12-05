import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_login/Presenter/PresenterMainMenuMVP.dart';
import 'package:test_login/Utils/AnimationSource.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ResponsiveWidget.dart';
import 'package:test_login/View/MiPersonalScreen.dart';
import 'package:test_login/View/interfaceMainMenuMVP.dart';

import 'LoginScreen.dart';

void main() {
  runApp(MainMenuScreen());
}

class MainMenuScreen extends StatefulWidget {
  StateMainMenuScreen createState() => StateMainMenuScreen();
}

class StateMainMenuScreen extends State<MainMenuScreen>
    with SingleTickerProviderStateMixin
    implements interfaceMainMenuMVP {
  bool closeSession = false;

  late PresenterMainMenuMVP presenterMainMenuMVP;
  late final controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..forward();

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1.5, 1.5),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.fastOutSlowIn,
  ));

  @override
  void initState() {
    // TODO: implement initState
    presenterMainMenuMVP = PresenterMainMenuMVP(this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: DataSource.primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                showLogOutOption();
              },
              icon: Icon(Icons.logout),
              tooltip: 'Cerrar sesión',
            )
          ],
          title: Text(
            'Administrador',
          ),
        ),
        body: ResponsiveWidget(
          mobile: MobileLayout(_offsetAnimation),
        ),
      ),
    );
  }

  void showLogOutOption() {
    showDialog(
        context: context,
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
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 17)),
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
                          presenterMainMenuMVP.requestModelLogOut();
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
    Navigator.pushAndRemoveUntil(
        context,
        AnimationSource.createRoute(MyAppLoginScreen()),
        (Route<dynamic> route) => false);
  }
}

class MobileLayout extends StatelessWidget {
  final Animation<Offset> _offsetAnimation;

  MobileLayout(this._offsetAnimation);

  final EdgeInsets _padding = EdgeInsets.all(0);
  final double textFont = 18;
  final RoundedRectangleBorder roundedStyle = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      side: BorderSide(color: DataSource.primaryColor, width: 3));
  final marginContainer = EdgeInsets.all(10);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SlideTransition(
                    position: _offsetAnimation,
                    child: GestureDetector(
                      onTap: () {
                        startNewRoute(context, MiPersonalScreen());
                      },
                      child: Card(
                        margin: EdgeInsets.fromLTRB(10, 10, 5, 5),
                        shape: roundedStyle,
                        elevation: 10,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 3,
                                //// alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Image.asset("assets/waitress.png"),
                                )
                                //),
                                ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: _padding,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                      color: DataSource.primaryColor),
                                  width: double.infinity,
                                  child: Text(
                                    'Mi personal',
                                    style: TextStyle(
                                        fontSize: textFont,
                                        color: Colors.white),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: SlideTransition(
                      position: _offsetAnimation,
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          margin: EdgeInsets.fromLTRB(5, 10, 10, 5),
                          shape: roundedStyle,
                          elevation: 10,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    child:
                                        Image.asset("assets/food_drinks.png"),
                                  )
                                  //),
                                  ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: _padding,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                        color: DataSource.primaryColor),
                                    width: double.infinity,
                                    child: Text('Platos y bebidas',
                                        style: TextStyle(
                                            fontSize: textFont,
                                            color: Colors.white),
                                        textAlign: TextAlign.center),
                                  ))
                            ],
                          ),
                        ),
                      )))
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: SlideTransition(
                position: _offsetAnimation,
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    shape: roundedStyle,
                    elevation: 10,
                    child: Column(
                      children: [
                        Expanded(
                            flex: 3,
                            //// alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Image.asset("assets/report.png"),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: _padding,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  color: DataSource.primaryColor),
                              width: double.infinity,
                              child: Text('Reporte de consumos',
                                  style: TextStyle(
                                      fontSize: textFont, color: Colors.white),
                                  textAlign: TextAlign.center),
                            ))
                      ],
                    ),
                  ),
                )))
      ],
    ));
  }

  void startNewRoute(BuildContext context, Widget routeDestination) {
    Route route = AnimationSource.createRoute(routeDestination);
    Navigator.of(context).push(route);
  }
}
