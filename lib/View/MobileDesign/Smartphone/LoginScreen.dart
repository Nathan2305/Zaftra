//@dart=2.9

//import 'dart:html';

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:RestaurantAdmin/Presenter/PresenterLoginMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:RestaurantAdmin/Utils/Methods.dart';
import 'package:RestaurantAdmin/Utils/WidgetsX.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/MainMenuScreen.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceLoginMVP.dart';
import 'dart:ui' as ui;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/RegisterAdminScreen.dart';

final TextEditingController controllerEmail = TextEditingController();
final TextEditingController controllerPasswd = TextEditingController();
BuildContext fullContext;
ProgressDialog pDialog;
AlertDialog alertDialog;
PresenterLoginMVP presenterLoginMVP;
bool isMobile;
bool isLandscape;
bool iskeyboardVisible;

void main() {
  runApp(MyAppLoginScreen());
}

class MyAppLoginScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Sizer(builder: (context, orientation, deviceType) {
      isMobile = deviceType == DeviceType.mobile;
      isLandscape = orientation == Orientation.landscape;
      return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
          ),
          body: LoginLayoutMobile());
    });
  }
}

class LoginLayoutMobile extends StatefulWidget {
  _LoginLayoutMobile createState() => _LoginLayoutMobile();
}

class _LoginLayoutMobile extends State<LoginLayoutMobile>
    implements interfaceLoginMVP {
  StreamSubscription<bool> keyboardSubscription;

  @override
  void initState() {
    // TODO: implement initState
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      setState(() {
        iskeyboardVisible = visible;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    fullContext = context;
    presenterLoginMVP = PresenterLoginMVP(this);
    return ContainerTemplate();
  }

  @override
  void notifyViewCloseLottieDialog() {
    //pDialog.hide();
    Navigator.of(fullContext, rootNavigator: true).pop();
  }

  @override
  void notifyViewShowErrorMsg(String msgError) {
    showDialogMsg(msgError, "error", 14.sp);
  }

  @override
  void notifyViewShowInfoMsg(String msgInfo) {
    showDialogMsg(msgInfo, "warning", 14.sp);
  }

  @override
  void notifyViewShowLottieDialog() {
    alertDialog = WidgetsX.showAlertDialogStandardLoading();
    showDialog(
        context: fullContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewShowSuccessFullLogin(String objectId) {
    Navigator.pushAndRemoveUntil(fullContext,
        Methods.createRoute(MainMenuScreen(objectId)), (Route<dynamic> route) => false);
  }

  showDialogMsg(String msg, String typeMsg, double sizeText) {
    AlertDialog alertDialog = WidgetsX.buildAlertDialog(msg, typeMsg, sizeText);
    showDialog(
        context: fullContext,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

class ContainerTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Container(
            width: 100.w,
            height: 30.h,
            child: iskeyboardVisible == null || !iskeyboardVisible
                ? CustomPaint(
                    painter: MyPainter(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5.w),
                      child: Text('Iniciar sesión',
                          style:
                              TextStyle(color: Colors.white, fontSize: 26.sp)),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [DataSource.primaryColor,DataSource.secondaryColor]
                      )
                    ),
                    child: Text('Iniciar sesión', style: TextStyle(color: Colors.white, fontSize: 26.sp))),
          ),
          BodyWidgets()
        ],
      ),
    );
  }
}

class BodyWidgets extends StatelessWidget {
  final sideSpaceMargin = isMobile ? 8.w : 14.w;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      // color: Colors.yellow,
      //width: 100.w,
      //height: 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin:
                EdgeInsets.only(left: sideSpaceMargin, right: sideSpaceMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _EditTextEmail(14.sp),
                _EditTextPassword(14.sp),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(fullContext,
                        Methods.createRoute(RegisterAdminScreen()));
                  },
                  child: Text('Registrate',
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          decoration: TextDecoration.underline)),
                ),
                margin: EdgeInsets.only(top: 5.h, right: 8.w),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Text('¿Olvidaste tu contraseña?',
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          decoration: TextDecoration.underline)),
                ),
                margin: EdgeInsets.only(top: 2.h, right: 8.w, bottom: 5.h),
              ),
            ],
          ),
          _ButtonLogin(),
        ],
      ),
    );
  }
}

class _ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isMobile
        ? Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 8.w),
            child: FabLogin(),
          )
        : Container(
            width: 12.w,
            height: 12.w,
            margin: EdgeInsets.only(right: 8.w),
            child: FabLogin(),
          );
  }
}

class FabLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      isExtended: true,
      mini: false,
      onPressed: () {
        initLogin();
      },
      backgroundColor: DataSource.primaryColor,
      child: Icon(Icons.forward_sharp),
      elevation: 10,
    );
  }
}

class CustomCliPathButtonLogin extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    final path = Path();
    //path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height * 0.5);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

void initLogin() {
  String emailTxt = controllerEmail.text;
  String passwd = controllerPasswd.text;
  presenterLoginMVP.requestModelValidateLogin(emailTxt, passwd);
}

class _EditTextPassword extends StatelessWidget {
  final textSize;

  _EditTextPassword(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
        cursorColor: DataSource.primaryColor,
        controller: controllerPasswd,
        obscureText: true,
        style: TextStyle(
            // height: heightText,
            color: Colors.black,
            fontSize: textSize,
            decorationColor: DataSource.primaryColor),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DataSource.primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DataSource.primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: 'Contraseña',
          labelStyle: TextStyle(color: DataSource.primaryColor),
          hintStyle: TextStyle(color: DataSource.primaryColor),
        ));
  }
}

class _EditTextEmail extends StatelessWidget {
  final textSize;

  _EditTextEmail(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      child: TextField(
          cursorColor: DataSource.primaryColor,
          controller: controllerEmail,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              // height: aspectRatio,
              color: Colors.black,
              fontSize: textSize,
              decorationColor: DataSource.primaryColor),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: DataSource.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: DataSource.primaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: DataSource.primaryColor),
            hintStyle: TextStyle(color: DataSource.primaryColor),
          )),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..shader = ui.Gradient.linear(
          Offset(0, size.height * 0.56),
          Offset(size.width * 1.00, size.height * 0.56),
          [DataSource.primaryColor, DataSource.secondaryColor],
          [0.00, 1.00]);

    Path path0 = Path();

      path0.moveTo(0, size.height * 0.8533333);
      path0.quadraticBezierTo(size.width * 0.2663194, size.height * 1.1166667,
          size.width * 0.4899306, size.height * 0.9100000);
      path0.cubicTo(
          size.width * 0.7510417,
          size.height * 0.6300000,
          size.width * 0.7750000,
          size.height * 0.4814667,
          size.width * 0.7982639,
          size.height * 0.3525000);
      path0.cubicTo(
          size.width * 0.8239583,
          size.height * 0.2204333,
          size.width * 0.8983472,
          size.height * 0.3573000,
          size.width * 0.9493056,
          size.height * 0.2658333);
      path0.quadraticBezierTo(
          size.width, size.height * 0.1816667, size.width, 0);
      path0.lineTo(0, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
