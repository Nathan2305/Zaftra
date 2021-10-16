// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:test_login/Presenter/PresenterLoginMVP.dart';
import 'package:test_login/Utils/AnimationSource.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/WidgetsX.dart';
import 'package:test_login/View/RegisterScreen.dart';
import 'package:test_login/View/interfaceLoginMVP.dart';
//import 'package:universal_io/io.dart';

//PresenterLoginMVP presenterLoginMVP;
PresenterLoginMVP presenterLoginMVP; //<--- variable can be null
final TextEditingController controllerEmail = TextEditingController();
final TextEditingController controllerPasswd = TextEditingController();
BuildContext fullcontext;
ProgressDialog pDialog;
bool isWideScreenWidth = false;
const primaryColor = Color(0xFFF134DE8);
const secondaryColor = Color(0xFFF429FEC);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget implements interfaceLoginMVP {
  get boxDecoration => BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            DataSource.primaryColor,
            DataSource.secondaryColor,
          ]));

  get boxDecorationCard => BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            DataSource.primaryColor,
            DataSource.secondaryColor,
          ]));

  @override
  Widget build(BuildContext context) {
    fullcontext = context;
    presenterLoginMVP = PresenterLoginMVP(LoginScreen());
    // TODO: implement build
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          isWideScreenWidth = true;
          return WideLayout();
        } else {
          return NormalLayout();
        }
      },
    );
  }

  @override
  void notifyViewShowErrorMsg(String msgError) {
    // TODO: implement notifyViewShowErrorMsg
    showDialogMsg(msgError, "error");
  }

  showDialogMsg(String msg, String typeMsg) {
    AlertDialog alertDialog = WidgetsX.buildAlertDialog(msg, typeMsg);
    showDialog(
        context: fullcontext,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewShowInfoMsg(String msgInfo) {
    // TODO: implement notifyViewShowInfoMsg
    showDialogMsg(msgInfo, "warning");
  }

  @override
  void notifyViewShowLottieDialog() {
    // TODO: implement notifyViewShowLottieDialog
    pDialog = WidgetsX.showProgressDialog(fullcontext,"Iniciando sesión");
    pDialog.show();
  }

  @override
  void notifyViewCloseLottieDialog() {
    // TODO: implement notifyViewCloseLottieDialog
    pDialog.hide();
  }
}

class WideLayout extends StatelessWidget {
  get boxDecoration => BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            DataSource.primaryColor,
            DataSource.secondaryColor,
          ]));

  get boxDecorationCard => BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            DataSource.primaryColor,
            DataSource.secondaryColor,
          ]));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [DataSource.primaryColor, DataSource.secondaryColor],
        )),
        child: Row(
          children: [
            Expanded(child: Container(), flex: 3),
            Expanded(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      'images/logo_app.png',
                      /*height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.height * 0.25,*/
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 20.0,
                      child: Container(
                        //height: MediaQuery.of(context).size.height * 0.9,
                        decoration: boxDecorationCard,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                  "Iniciar sesión",
                                  textScaleFactor: 2,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Align(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _EditTextEmail(boxDecorationCard),
                                  _EditTextPassword(boxDecorationCard),
                                ],
                              ),
                              alignment: Alignment.center,
                            ),
                            Align(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(20, 12, 20, 12),
                                  width: double.infinity,
                                  child: _ButtonLogin(),
                                ),
                                alignment: Alignment.bottomCenter)
                          ],
                        ),
                      ),
                    ),
                    flex: 3,
                  )
                ],
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}

class NormalLayout extends StatelessWidget {
  get boxDecoration => BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            DataSource.primaryColor,
            DataSource.secondaryColor,
          ]));

  get boxDecorationCard => BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            DataSource.primaryColor,
            DataSource.secondaryColor,
          ]));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Image.asset(
                  'images/logo_app.png',
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: boxDecoration),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CardLogin(boxDecorationCard),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardLogin extends StatelessWidget {
  BoxDecoration boxDecorationCard;

  CardLogin(this.boxDecorationCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double withContainer = 0;
    if (isWideScreenWidth) {
      withContainer = MediaQuery.of(context).size.width * 0.3;
    }
    return Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 20.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: boxDecorationCard,
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
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _EditTextEmail(boxDecorationCard),
                  _EditTextPassword(boxDecorationCard),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: RichText(
                        text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                          TextSpan(
                              text: 'Registrate',
                              style: TextStyle(
                                  color: Colors.yellowAccent,
                                  decoration: TextDecoration.underline,fontSize: 18),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                 Navigator.of(context).push(AnimationSource.createRoute());
                                }),
                        ])),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      width: double.infinity,
                      child: _ButtonLogin()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: secondaryColor,
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
  BoxDecoration boxDecorationCard;

  _EditTextPassword(this.boxDecorationCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: boxDecorationCard,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        controller: controllerPasswd,
      ),
    );
  }
}

class _EditTextEmail extends StatelessWidget {
  BoxDecoration boxDecorationCard;

  _EditTextEmail(this.boxDecorationCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: boxDecorationCard,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        controller: controllerEmail,
        //border: OutlineInputBorder(),
      ),
    );
  }
}
