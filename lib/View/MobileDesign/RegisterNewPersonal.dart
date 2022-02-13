//@dart=2.9

import 'dart:async';
import 'dart:io';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_login/Presenter/PresenterRegisterUserMVP.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ResponsiveWidget.dart';
import 'package:test_login/Utils/WidgetsX.dart';
import 'package:test_login/View/Interfaces/interfaceRegisterUserMVP.dart';
import 'package:test_login/main.dart';
import 'package:image_picker/image_picker.dart';

import 'UserCreatedDetails.dart';

void main() {
  runApp(RegisterNewPersonalScreen());
}

OutlineInputBorder outlineInputBorder;
TextEditingController textEditingControllerEmail;
TextEditingController textEditingControllerName;
TextEditingController textEditingControllerLastName;

BuildContext builderAlertDialogCtx;
String emailDomain = "";
PresenterRegisterUserMVP presenterRegisterUserMVP;

class RegisterNewPersonalScreen extends StatelessWidget {
  RegisterNewPersonalScreen();

  final nameRest = MyAppMain.currentUser
      .getProperty(DataSource.COLUMN_NAME_RESTAURANT)
      .toString()
      .split(" ");

  @override
  Widget build(BuildContext context) {
    for (int k = 0; k < nameRest.length; k++) {
      String item = nameRest[k];
      if (k == 0) {
        emailDomain = item;
      } else {
        emailDomain = emailDomain + item;
      }
    }
    emailDomain = '@' + emailDomain + '.com';

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Nuevo personal',
              style: TextStyle(fontSize: 22, color: Colors.white))),
      body: ResponsiveWidget(
        mobile: MobileLayoutRegisterNewPersonal(),
      ),
    );
  }
}

class MobileLayoutRegisterNewPersonal extends StatefulWidget {
  _MobileLayoutStaFulWidget createState() => _MobileLayoutStaFulWidget();
}

class _MobileLayoutStaFulWidget extends State<MobileLayoutRegisterNewPersonal>
    implements interfaceRegisterUserMVP {
  BuildContext contexAlertCamera;

  bool userSuccessfulCreated = false;
  File pickedImage;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    presenterRegisterUserMVP = PresenterRegisterUserMVP(this);
    outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: DataSource.primaryColor, width: 1.0),
      borderRadius: BorderRadius.circular(15),
    );
    textEditingControllerEmail = TextEditingController();
    textEditingControllerName = TextEditingController();
    textEditingControllerLastName = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingControllerName.dispose();
    textEditingControllerEmail.dispose();
    textEditingControllerLastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Stack(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        DataSource.secondaryColor,
                        DataSource.primaryColor,
                      ],
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  padding: EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                        side: BorderSide(
                            width: 2, color: DataSource.primaryColor)),
                    color: Colors.white,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        //alignment: Alignment.bottomCenter,
                        child: pickedImage==null?Image(
                            width: 100,
                            height: 100,
                            image:  AssetImage('assets/waitress.png')):
                        Image.file(pickedImage),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(left: 125),
                          child: FloatingActionButton(
                            child: Icon(Icons.add_a_photo),
                            onPressed: () {
                              showOptionsPhoto();
                            },
                            backgroundColor: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                _EditTextEmail(),
                _EditTextNameUser(),
                _EditTextLastNameUser(),
                ButtonRegistrar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void notifyViewStartLoading() {
    // TODO: implement notifyViewStartLoading
    AlertDialog alertDialog = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 120),
      content: FractionallySizedBox(
        heightFactor: 0.1,
        child: SpinKitChasingDots(
          duration: Duration(seconds: 2),
          color: DataSource.primaryColor,
        ),
      ),
      elevation: 24.0,
    );
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          builderAlertDialogCtx = builderContext;
          return alertDialog;
        });
  }

  @override
  void notifyViewEmptyFields() {
    // TODO: implement notifyViewEmptyFields
    //AlertDialog alertDialog =
    //WidgetsX.buildAlertDialog("Debe llenar todos los campos", "warning",13.sp);
    /*showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return alertDialog;
        });*/
  }

  @override
  void notifyViewShowMsgError(String msgError) {
    if (builderAlertDialogCtx != null) {
      Navigator.pop(builderAlertDialogCtx);
    }
    /*AlertDialog alertDialog = WidgetsX.buildAlertDialog(msgError, "error",13.sp);
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return alertDialog;
        });*/
  }

  @override
  void notifyViewSuccessfulUserCreated(
      BackendlessUser newBackendlessUserCreated) {
    Navigator.pop(builderAlertDialogCtx);
    textEditingControllerLastName.clear();
    textEditingControllerEmail.clear();
    textEditingControllerName.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UserCreatedDetails(newUserCreated: newBackendlessUserCreated),
        ));
  }

  void showOptionsPhoto() {
    AlertDialog alertDialog = AlertDialog(
      title: Text('Elija una opción'),
      elevation: 10,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: Icon(Icons.camera,
                    color: DataSource.primaryColor, size: 40),
                onTap: () {
                  openCamera();
                },
              ),
              Text('Cámara'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child:
                Icon(Icons.image, color: DataSource.primaryColor, size: 40),
              ),
              Text('Galería'),
            ],
          ),
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext alertDialogOptionCamera) {
          contexAlertCamera = alertDialogOptionCamera;
          return alertDialog;
        });
  }

  void openCamera() async {
    if (contexAlertCamera != null) {
      Navigator.pop(contexAlertCamera);
    }
    pickedImage =
    (await ImagePicker.platform.pickImage(source: ImageSource.camera)) as File;
    if (pickedImage != null) {
      setState(() {});
    }
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);

    var firstEnd = Offset(size.width / 2.25, size.height - 50);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width - size.width / 3.24, size.height - 105);

    var secondEnd = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class _EditTextLastNameUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text('Apellidos',
                  style:
                  TextStyle(color: DataSource.primaryColor, fontSize: 15)),
            ),
            TextField(
                cursorColor: DataSource.primaryColor,
                controller: textEditingControllerLastName,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  // height: aspectRatio,
                  //color: Colors.black,
                    fontSize: 17,
                    decorationColor: DataSource.primaryColor),
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  labelStyle: TextStyle(color: DataSource.primaryColor),
                  hintStyle: TextStyle(color: DataSource.primaryColor),
                ))
          ],
        ));
  }
}

class ButtonRegistrar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: DataSource.primaryColor,
          elevation: 10,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: TextStyle(fontSize: 20)),
      onPressed: () =>
      {
        initRegisterUser(),
      },
      child: Text(
        'Registrar usuario',
      ),
    );
  }

  initRegisterUser() {
    String name = textEditingControllerName.text;
    String email = textEditingControllerEmail.text + emailDomain;
    String lastName = textEditingControllerLastName.text;
    presenterRegisterUserMVP.requestModelRegisterUser(name, lastName, email);
  }
}

class _EditTextEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text('Email',
                  style: TextStyle(
                    color: DataSource.primaryColor,
                    fontSize: 15,
                  )),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                      autofocus: true,
                      cursorColor: DataSource.primaryColor,
                      controller: textEditingControllerEmail,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 17,
                          decorationColor: DataSource.primaryColor),
                      decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        labelStyle: TextStyle(color: DataSource.primaryColor),
                        hintStyle: TextStyle(color: DataSource.primaryColor),
                      )),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.grey, width: 20),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(emailDomain,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 17,
                            backgroundColor: Colors.grey,
                            color: Colors.white)),
                  ),
                  flex: 2,
                ),
              ],
            )
          ],
        ));
  }
}

class _EditTextNameUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text('Nombre',
                  style:
                  TextStyle(color: DataSource.primaryColor, fontSize: 15)),
            ),
            TextField(
                cursorColor: DataSource.primaryColor,
                controller: textEditingControllerName,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: 17, decorationColor: DataSource.primaryColor),
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  labelStyle: TextStyle(color: DataSource.primaryColor),
                  hintStyle: TextStyle(color: DataSource.primaryColor),
                ))
          ],
        ));
  }
}
