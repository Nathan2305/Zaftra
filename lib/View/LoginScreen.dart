//@dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:test_login/Presenter/PresenterLoginMVP.dart';
import 'package:test_login/Utils/AnimationSource.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ResponsiveWidget.dart';
import 'package:test_login/Utils/WidgetsX.dart';
import 'package:test_login/View/MainMenuScreen.dart';
import 'package:test_login/View/RegisterScreen.dart';
import 'package:test_login/View/interfaceLoginMVP.dart';

final TextEditingController controllerEmail = TextEditingController();
final TextEditingController controllerPasswd = TextEditingController();
BuildContext fullcontext;
ProgressDialog pDialog;
bool isWideScreenWidth = false;
PresenterLoginMVP presenterLoginMVP;

void main() {
  runApp(MyAppLoginScreen());
}

class MyAppLoginScreen extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: MaterialApp(
      useInheritedMediaQuery: true,
        initialRoute: '/login',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/login': (context) => FirstScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/second': (context) => MainMenuScreen(),
        },
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsiveWidget(
      mobile: MobileLayoutLogin(),
    );
  }
}

class MobileLayoutLogin extends StatelessWidget implements interfaceLoginMVP {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    fullcontext = context;
    presenterLoginMVP = PresenterLoginMVP(MobileLayoutLogin());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        //margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      DataSource.primaryColor,
                      DataSource.secondaryColor
                    ])),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 10.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    DataSource.primaryColor,
                                    DataSource.secondaryColor
                                  ])),
                          width: size.width * 0.85,
                          //thw following height is set if screen resolution is very low
                          height: size.height <=
                                  DataSource.SIZE_HEIGHT_VERY_SMALL_DEVICE
                              ? size.height * 0.85
                              : size.height * 0.6,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "Iniciar sesión",
                                    textScaleFactor: 2.2,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _EditTextEmail(),
                                    _EditTextPassword(),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: size.height <=
                                        DataSource.SIZE_HEIGHT_SMALL_DEVICE
                                    ? WidgetSmallDeviceBottom()
                                    : WidgetNotSmallDeviceBottom(),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void notifyViewCloseLottieDialog() {
    pDialog.hide();
  }

  @override
  void notifyViewShowErrorMsg(String msgError) {
    showDialogMsg(msgError, "error");
  }

  @override
  void notifyViewShowInfoMsg(String msgInfo) {
    showDialogMsg(msgInfo, "warning");
  }

  @override
  void notifyViewShowLottieDialog() {
    pDialog = WidgetsX.showProgressDialog(fullcontext, "Iniciando sesión");
    pDialog.show();
  }

  @override
  void notifyViewShowSuccessFullLogin() {
    //Navigator.push(fullcontext, AnimationSource.createRoute(MainMenuScreen()));
    Navigator.pushNamedAndRemoveUntil(fullcontext, "/second", (Route<dynamic> route) => false);
  }

  showDialogMsg(String msg, String typeMsg) {
    AlertDialog alertDialog = WidgetsX.buildAlertDialog(msg, typeMsg);
    showDialog(
        context: fullcontext,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

class WidgetNotSmallDeviceBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RichText(
            text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
              TextSpan(
                  text: '¿Olvidaste tu clave?',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 16),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Navigator.of(context).push(AnimationSource.createRoute());
                    }),
            ])),
        Container(
          margin: EdgeInsets.fromLTRB(40, 12, 40, 12),
          width: double.infinity,
          child: _ButtonLogin(),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: RichText(
              text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                TextSpan(
                    text: 'Registrate',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context)
                            .push(AnimationSource.createRoute(Register()));
                      }),
              ])),
        )
      ],
    );
  }
}

class WidgetSmallDeviceBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 12, 10, 12),
          width: double.infinity,
          child: _ButtonLogin(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
              child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: '¿Olvidaste tu clave?',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigator.of(context).push(AnimationSource.createRoute());
                          }),
                  ])),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Registrate',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 16),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context)
                                .push(AnimationSource.createRoute(Register()));
                          }),
                  ])),
            ),
          ],
        )
      ],
    );
  }
}

class _ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: DataSource.secondaryColor,
          elevation: 10,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: TextStyle(fontSize: 20)),
      onPressed: () => {
        initLogin(),
      },
      child: Text(
        'Ingresar',
      ),
    );
  }
}

void initLogin() {
  String emailTxt = controllerEmail.text;
  String passwd = controllerPasswd.text;
  presenterLoginMVP.requestModelValidateLogin(emailTxt, passwd);
}

class _EditTextPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: boxDecorationContainer,
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: TextField(
            cursorColor: Colors.white,
            controller: controllerPasswd,
            obscureText: true,
            style: TextStyle(
                // height: heightText,
                color: Colors.white,
                fontSize: 17,
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
            )));
  }
}

class _EditTextEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: boxDecorationContainer,
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: TextField(
            cursorColor: Colors.white,
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                // height: aspectRatio,
                color: Colors.white,
                fontSize: 17,
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
            )));
  }
}
