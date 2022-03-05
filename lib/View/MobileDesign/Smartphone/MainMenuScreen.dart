import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:RestaurantAdmin/Utils/Methods.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceMainMenuMVP.dart';
import 'dart:ui' as ui;

import '../../../main.dart';
import 'LoginScreen.dart';
import 'MiPersonalListScreen.dart';
import 'MisProductos.dart';

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
        body: MainMenuScreen(),
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
    'Platos',
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
    var businessName=MyAppMain.currentUser.getProperty(DataSource.COLUMN_NAME_RESTAURANT).toString();
    return Column(
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
                  margin: EdgeInsets.only(left: 5.w,top: 4.h),
                  child: Text(businessName,style: TextStyle(fontSize: 22.sp,color: Colors.white),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text('Ventas',style: TextStyle(fontSize: 15.sp,color: Colors.white)),
                          Text('1026',style: TextStyle(fontSize: 15.sp,color: Colors.white))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text('Personal',style: TextStyle(fontSize: 15.sp,color: Colors.white)),
                          Text('1024',style: TextStyle(fontSize: 15.sp,color: Colors.white))
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
                   Transform(
                     alignment: Alignment.bottomCenter,
                     transform: Matrix4.identity()
                       ..setEntry(3, 2, 0.002)
                       ..rotateX(verticalDrag / 180 * pi),
                     child: GestureDetector(
                       onTap: () {
                         Methods.startNewRoute(context, PersonalScreenState());
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
                         Methods.startNewRoute(context, MisProductos());
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
                               width: 25.w,
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
                 ],
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
           ),
          ),
        )
      ],
    );
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
