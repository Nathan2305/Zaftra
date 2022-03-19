//@dart=2.9
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';


import '../../Presenter/PresenterLoginMVP.dart';
import '../../Utils/DataSource.dart';
import '../../Utils/Methods.dart';
import '../Interfaces/interfaceLoginMVP.dart';
import 'MainMenuWeb.dart';

void main() {
  runApp(LoginLayoutWeb());
}

TextEditingController controllerEmail = TextEditingController();
TextEditingController controllerPasswd = TextEditingController();
var initPage = 0;
PresenterLoginMVP presenterLoginMVP;

class LoginLayoutWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StatefulLoginWeb();
  }
}

class StatefulLoginWeb extends StatefulWidget {
  _BodyStatefulLoginWeb createState() => _BodyStatefulLoginWeb();
}

class _BodyStatefulLoginWeb extends State<StatefulLoginWeb>
    implements interfaceLoginMVP {
  var controllerPage = PageController(initialPage: initPage);
  bool visibleMsgEmpty, startLoggingIn;
  Timer timer;
  var msgErrorInfo;
  @override
  void initState() {
    // TODO: implement initState
    presenterLoginMVP = PresenterLoginMVP(this);
    visibleMsgEmpty = false;
    startLoggingIn = false;
    msgErrorInfo="";
    initTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var opacityVal = startLoggingIn ? 0.7 : 1;
    return Opacity(
        opacity: opacityVal,
        child: AbsorbPointer(
            absorbing: startLoggingIn,
            child: Container(
              height: 100.h,
              width: 100.w,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100.w,
                            height: 100.h,
                            child: CustomPaint(
                              painter: TemplateWebLogin(),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: PageView(
                            controller: controllerPage,
                            scrollDirection: Axis.horizontal,
                            children: [
                              PageWidget1(),
                              PageWidget2(),
                              PageWidget3(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //color: Colors.blueAccent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Inicio de sesión',
                              style: TextStyle(
                                  fontSize: 6.sp, color: Colors.blueAccent)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _EditTextEmailWeb(),
                              Divider(
                                height: 0.9.h,
                              ),
                              _EditTextPasswordWeb(),
                              Visibility(
                                  visible: visibleMsgEmpty,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 2.h),
                                    child: Text(
                                      msgErrorInfo,
                                      style: TextStyle(
                                          fontSize: 3.5.sp, color: Colors.red),
                                    ),
                                  ))
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _ButtonWebLogin(),
                              Divider(
                                color: Colors.transparent,
                                height: 2.h,
                              ),
                              Visibility(
                                visible: startLoggingIn,
                                child: Container(
                                  width: 5.w,
                                  height: 3.h,
                                  child: SpinKitPianoWave(
                                    color: DataSource.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  void initTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      startControllerScrollPages(initPage++);
    });
  }

  void startControllerScrollPages(int toPage) {
    controllerPage.animateToPage(toPage,
        duration: Duration(seconds: 3), curve: Curves.fastLinearToSlowEaseIn);
    if (toPage >= 2) {
      initPage = -1;
    }
  }

  @override
  void notifyViewCloseLottieDialog() {
    // TODO: implement notifyViewCloseLottieDialog
    /*setState(() {
      startLoggingIn = false;
    })*/;
  }

  @override
  void notifyViewShowErrorMsg(String msgError) {
    // TODO: implement notifyViewShowErrorMsg
    setState(() {
      startLoggingIn = false;
      this.msgErrorInfo=msgError;
      visibleMsgEmpty = true;
    });

  }

  @override
  void notifyViewShowInfoMsg(String msgInfo) {
    // TODO: implement notifyViewShowInfoMsg
    //email or pass is empty...
    setState(() {
      this.msgErrorInfo=msgInfo;
      visibleMsgEmpty = true;
    });
  }

  @override
  void notifyViewShowLottieDialog() {
    // TODO: implement notifyViewShowLottieDialog
    //email and passwd are not empty.. so show dialog message loading...
    setState(() {
      startLoggingIn = true;
      if(visibleMsgEmpty)
        visibleMsgEmpty=false;
    });
  }

  @override
  void notifyViewShowSuccessFullLogin(String objectId) {
    // TODO: implement notifyViewShowSuccessFullLogin
    Navigator.pushAndRemoveUntil(context, Methods.createRoute(MainMenuWeb()), (Route<dynamic> route) => false);
  }
}

class PageWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(left: 2.w, right: 22.w),
      alignment: Alignment.centerLeft,
      //sdcolor: Colors.red,
      child: Text(
        'Regístrate, gestiona tu personal y platos',
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
          fontSize: 8.sp,
        ),
      ),
    );
  }
}

class PageWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(left: 2.w, right: 22.w),
        alignment: Alignment.centerLeft,
        // color: Colors.yellow,
        child: Text(
          'Visualiza tus ventas, así como reportes por personal',
          style: TextStyle(color: Colors.white, fontSize: 8.sp),
        ));
  }
}

class PageWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(left: 2.w, right: 22.w),
        alignment: Alignment.centerLeft,
        //color: Colors.green,
        child: Text(
          'Únete y descubre lo que te espera',
          style: TextStyle(color: Colors.white, fontSize: 8.sp),
        ));
  }
}

class _ButtonWebLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 15.w,
      height: 3.w,
      child: ElevatedButton(
        onPressed: () {
          initLoginWeb();
        },
        child: Text('Ingresar', style: TextStyle(fontSize: 5.sp)),
        style: ElevatedButton.styleFrom(
            elevation: 10,
            primary: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }

  void initLoginWeb() {
    var emailTxt = controllerEmail.text;
    var passwdTxt = controllerPasswd.text;
    presenterLoginMVP.requestModelValidateLogin(emailTxt, passwdTxt);
  }
}

class TemplateWebLogin extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var widthParent = size.width;
    var heightParent = size.height;
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(widthParent * 0.13, heightParent * 0.51),
        Offset(widthParent * 0.89, heightParent * 0.00),
        [DataSource.secondaryColor, DataSource.primaryColor],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(widthParent * 0.0023114, 0);
    path0.lineTo(widthParent * 0.8963724, heightParent * -0.0011820);
    path0.quadraticBezierTo(widthParent * 0.9003291, heightParent * 0.0399689,
        widthParent * 0.8850241, heightParent * 0.0412131);
    path0.cubicTo(
        widthParent * 0.8499599,
        heightParent * 0.0517885,
        widthParent * 0.8182665,
        heightParent * 0.1085070,
        widthParent * 0.8744222,
        heightParent * 0.1658320);
    path0.cubicTo(
        widthParent * 0.9327689,
        heightParent * 0.2563608,
        widthParent * 0.8156100,
        heightParent * 0.2800778,
        widthParent * 0.8116533,
        heightParent * 0.4233437);
    path0.cubicTo(
        widthParent * 0.8094302,
        heightParent * 0.5196423,
        widthParent * 0.9962841,
        heightParent * 0.4862830,
        widthParent * 0.9843660,
        heightParent * 0.6996579);
    path0.quadraticBezierTo(widthParent * 0.9873114, heightParent * 0.8134837,
        widthParent * 0.9255457, heightParent);
    path0.lineTo(0, heightParent);
    path0.lineTo(0, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _EditTextEmailWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: TextField(
        cursorColor: Colors.white,
        controller: controllerEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          fillColor:DataSource.primaryColor,
          filled: true,
          border: InputBorder.none,
          hintText: 'Email',
          focusColor: Colors.white,
          hoverColor: Colors.transparent,
          //enableBorder shows textfield with borders...
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            borderRadius: BorderRadius.circular(15),
          ),
          //focusedBorder shows textfield with borders when clicked...
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        style: TextStyle(
            color: Colors.white,
            fontSize: 4.sp,
            backgroundColor: Colors.transparent,
            decorationColor: Colors.transparent),
      ),
    );
  }
}

class _EditTextPasswordWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: TextField(
          obscureText: true,
          cursorColor: Colors.white,
          controller: controllerPasswd,
          style: TextStyle(
              color: Colors.white,
              fontSize: 4.sp,
              backgroundColor: Colors.transparent),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
            fillColor: DataSource.primaryColor,
            filled: true,
            hintText: 'Contraseña',
            focusColor: Colors.white,
            hoverColor: Colors.transparent,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
          )),
    );
  }
}
