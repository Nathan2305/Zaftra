//@dart=2.9

import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:test_login/Presenter/PresenterLoginMVP.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/EditTextMail_Util.dart';
import 'package:test_login/Utils/Methods.dart';
import 'package:test_login/Utils/WidgetsX.dart';
import 'package:test_login/View/MobileDesign/MainMenuScreen.dart';
import 'package:test_login/View/Interfaces/interfaceLoginMVP.dart';

final TextEditingController controllerEmail = TextEditingController();
final TextEditingController controllerPasswd = TextEditingController();
BuildContext fullContext;
ProgressDialog pDialog;
AlertDialog alertDialog;
PresenterLoginMVP presenterLoginMVP;
bool isMobile;
bool isTablet;
bool isWeb;
bool isLandscape;

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
      isTablet = deviceType == DeviceType.tablet;
      isLandscape = orientation == Orientation.landscape;
      return  MaterialApp(
              useInheritedMediaQuery: true,
              home: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    toolbarHeight: 0,
                    backgroundColor: DataSource.primaryColor,
                  ),
                  body: isMobile
                      ? LoginLayoutMobile()
                      : isTablet
                          ? LoginLayoutTablet()
                          : null),
            );
    });
  }
}


class LoginLayoutMobile extends StatelessWidget implements interfaceLoginMVP {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    fullContext = context;
    presenterLoginMVP = PresenterLoginMVP(LoginLayoutMobile());
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
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewShowSuccessFullLogin() {
    Navigator.pushAndRemoveUntil(fullContext,
        Methods.createRoute(MainMenuAdmin()), (Route<dynamic> route) => false);
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

class BodyWidgets extends StatelessWidget {
  final sideSpaceMargin = isMobile ? 8.w : 14.w;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 100.w,
      height: 65.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 8.w),
              child: Text('Iniciar sesión',
                  style: TextStyle(color: Colors.white, fontSize: 25.sp))),
          Container(
            margin:
                EdgeInsets.only(left: sideSpaceMargin, right: sideSpaceMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _EditTextEmail(12.sp),
                _EditTextPassword(12.sp),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _ButtonLogin(),
          )
        ],
      ),
    );
  }
}

class LoginLayoutTablet extends StatelessWidget implements interfaceLoginMVP {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    fullContext = context;
    presenterLoginMVP = PresenterLoginMVP(LoginLayoutMobile());
    return isLandscape
        ? ContainerTemplateLandsScapeTablet()
        : ContainerTemplate();
  }

  @override
  void notifyViewCloseLottieDialog() {
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
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewShowSuccessFullLogin() {
    Navigator.pushAndRemoveUntil(fullContext,
        Methods.createRoute(MainMenuAdmin()), (Route<dynamic> route) => false);
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

class ContainerTemplateLandsScapeTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100.w,
      width: 100.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 50.h,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: DataSource.primaryColor,
              width: 50.h,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              child: Card(
                shadowColor: Colors.grey,
                elevation: 5,
                margin: EdgeInsets.all(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: DataSource.primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  margin: EdgeInsets.only(left: 50.h - 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Iniciar sesión',
                          style:
                              TextStyle(fontSize: 16.sp, color: Colors.white)),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 4.h, right: 4.h),
                            child: _EditTextEmail(12.sp),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4.h, right: 4.h),
                            child: _EditTextPassword(12.sp),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text('Registrate',
                                    style: TextStyle(
                                        fontSize: 8.sp, color: Colors.white)),
                                margin: EdgeInsets.only(top: 10, right: 10),
                              ),
                              Container(
                                child: Text('¿Olvidaste tu contraseña?',
                                    style: TextStyle(
                                        fontSize: 8.sp, color: Colors.white)),
                                margin: EdgeInsets.only(top: 10, left: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.h, right: 8.h),
                        width: double.infinity,
                        child: _ButtonLoginLandscape(14.sp),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
          /**/
          ,
        ],
      ),
    );
  }
}

class _ButtonLoginLandscape extends StatelessWidget {
  final textSizeButton;

  _ButtonLoginLandscape(this.textSizeButton);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: DataSource.primaryColor,
            padding: EdgeInsets.all(10),
            elevation: 5),
        onPressed: () {
          initLogin();
        },
        child: Text(
          'Ingresar',
          style: TextStyle(fontSize: textSizeButton),
        ));
  }
}

class LoginSidePainterTablet extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double withParent = size.width;
    double heightParent = size.height;
    // TODO: implement paint
    final paint = Paint()
      ..color = DataSource.primaryColor
      ..style = PaintingStyle.fill;

    // final arc = Path();
    // final arc2 = Path();
    final path = Path()
      ..lineTo(withParent, 0)
      ..lineTo(withParent, heightParent)
      ..lineTo(0, heightParent)
      ..quadraticBezierTo(
          0, heightParent * 0.75, withParent * 0.25, heightParent * 0.5)
      ..moveTo(0, 0)
      ..quadraticBezierTo(
          0, heightParent * 0.25, withParent * 0.25, heightParent * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class _ButtonLogin extends StatelessWidget {
  final rightMarginFab = isTablet ? 14.w : 8.w;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isMobile
        ? Container(
            margin: EdgeInsets.only(right: rightMarginFab),
            child: FabLogin(),
          )
        : Container(
            width: 12.w,
            height: 12.w,
            margin: EdgeInsets.only(right: rightMarginFab),
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
      child: Icon(Icons.forward_sharp, size: 4.h),
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
            color: Colors.white,
            fontSize: textSize,
            decorationColor: Colors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: 'Contraseña',
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
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
          cursorColor: Colors.white,
          controller: controllerEmail,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              // height: aspectRatio,
              color: Colors.white,
              fontSize: textSize,
              decorationColor: Colors.white),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
          )),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DataSource.primaryColor
      ..style = PaintingStyle.fill
      ..shader = SweepGradient(center: Alignment.center, colors: [
        Color.fromARGB(255, 255, 0, 0),
        Color.fromARGB(255, 255, 255, 0),
        DataSource.secondaryColor,
        DataSource.primaryColor,
        //Color.fromARGB(255, 0, 0, 255),
        //Color.fromARGB(255, 255, 0, 255),
        Color.fromARGB(255, 255, 0, 0),
      ]).createShader(
          Rect.fromLTRB(size.width, size.height, size.width, size.height));

    final path = Path()
      ..moveTo(size.width * 0.6, 0)
      ..lineTo(size.width * 0.6, size.height * 0.15)
      ..lineTo(size.width, size.height * 0.28)
      ..lineTo(size.width, 0)

      //left side
      ..moveTo(0, size.height * 0.3)
      ..lineTo(size.width * 0.1, size.height * 0.2)
      ..lineTo(size.width, size.height * 0.48)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    //final rect=Rect.fromPoints(Offset(size.width * 0.6, 0),Offset(size.width, size.height*0.4));

    // canvas.drawRRect(RRect.fromRectAndCorners(rect, bottomLeft: Radius.circular(600),bottomRight: Radius.circular(50)), paint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class ContainerTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100.w,
              height: 100.h,
              child: CustomPaint(
                painter: MyPainter(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BodyWidgets(),
          )
        ],
      ),
    );
  }
}
