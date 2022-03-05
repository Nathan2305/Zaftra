//@dart=2.9

import 'dart:async';

//import 'dart:html';
import 'dart:io';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:RestaurantAdmin/Presenter/PresenterRegisterUserMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:RestaurantAdmin/Utils/ResponsiveWidget.dart';
import 'package:RestaurantAdmin/Utils/WidgetsX.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceRegisterUserMVP.dart';
import 'package:RestaurantAdmin/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
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
List<BackendlessUser> listWorkers;

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

    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text('Nuevo personal',
                  style: TextStyle(fontSize: 18.sp, color: Colors.white))),
          body: MobileLayoutRegisterNewPersonal(),
        );
      },
    );
  }
}

class MobileLayoutRegisterNewPersonal extends StatefulWidget {
  _MobileLayoutStaFulWidget createState() => _MobileLayoutStaFulWidget();
}

class _MobileLayoutStaFulWidget extends State<MobileLayoutRegisterNewPersonal>
    implements interfaceRegisterUserMVP {
  BuildContext contextAlertCamera;
  bool showLoadingProgress = false;
  var opacity = 1.0;

  //bool userSuccessfulCreated = false;

  //File pickedImage;

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
    if (listWorkers != null && listWorkers.isNotEmpty) {
      listWorkers.clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: SingleChildScrollView(
          reverse: true,
          child: AbsorbPointer(
            absorbing: showLoadingProgress,
            child: Opacity(
              opacity: opacity,
              child: Column(
                children: [
                  Container(
                    width: 100.w,
                    height: 35.h,
                    child: CustomPaint(
                      painter: PainterRegisterPersonal(),
                      child: Visibility(
                        visible: showLoadingProgress,
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: SpinKitCircle(
                            size: 20.w,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        _EditTextEmail(12.sp),
                        _EditTextNameUser(12.sp),
                        _EditTextLastNameUser(12.sp),
                        ButtonRegistrar(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          if (!showLoadingProgress) {
            Navigator.pop(context, listWorkers);
          }
          return showLoadingProgress ? false : true;
        });
  }

  @override
  void notifyViewStartLoading() {
    // TODO: implement notifyViewStartLoading
    setState(() {
      showLoadingProgress = true;
      opacity = 0.7;
    });
  }

  @override
  void notifyViewEmptyFields() {
    // TODO: implement notifyViewEmptyFields
    AlertDialog alertDialog = WidgetsX.buildAlertDialog(
        "Debe llenar todos los campos", "warning", 13.sp);
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return alertDialog;
        });
  }

  @override
  void notifyViewShowMsgError(String msgError) {
    setState(() {
      showLoadingProgress = false;
      opacity = 1.0;
    });
    AlertDialog alertDialog =
        WidgetsX.buildAlertDialog(msgError, "error", 13.sp);
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return alertDialog;
        });
  }

  @override
  void notifyViewSuccessfulUserCreated(
      BackendlessUser newBackendlessUserCreated) {
    var nameUserCreated = newBackendlessUserCreated
        .getProperty(DataSource.COLUMN_NAME)
        .toString();
    setState(() {
      showLoadingProgress = false;
      opacity = 1.0;
    });
    textEditingControllerLastName.clear();
    textEditingControllerEmail.clear();
    textEditingControllerName.clear();
    var snackBar = SnackBar(content: Text("Se creó el usuario "+nameUserCreated+" correctamente"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (listWorkers == null || listWorkers.isEmpty) {
      listWorkers = List();
    }
    listWorkers.add(newBackendlessUserCreated);
    //Navigator.pop(context,newBackendlessUserCreated);
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
          contextAlertCamera = alertDialogOptionCamera;
          return alertDialog;
        });
  }

  void openCamera() async {
    if (contextAlertCamera != null) {
      Navigator.pop(contextAlertCamera);
    }
    /*pickedImage = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera)) as File;
    if (pickedImage != null) {
      setState(() {});
    }*/
  }
}

class PainterRegisterPersonal extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(0, size.height * 0.50),
        Offset(size.width * 1.00, size.height * 0.50),
        [DataSource.primaryColor, DataSource.secondaryColor],
        [0.00, 1.00]);

    Path path0 = Path();
    path0.moveTo(0, size.height);
    path0.quadraticBezierTo(size.width * 0.4137500, size.height * 0.8066667,
        size.width * 0.4150000, size.height * 0.5500000);
    path0.cubicTo(
        size.width * 0.4175000,
        size.height * 0.3025000,
        size.width * 0.6558333,
        size.height * 0.5550000,
        size.width * 0.7883333,
        size.height * 0.5600000);
    path0.quadraticBezierTo(size.width * 0.9075000, size.height * 0.5558333,
        size.width * 0.9983333, 0);
    path0.lineTo(0, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class _EditTextLastNameUser extends StatelessWidget {
  final textHeight;

  _EditTextLastNameUser(this.textHeight);

  @override
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
                  style: TextStyle(
                      color: DataSource.primaryColor, fontSize: textHeight)),
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
      onPressed: () => {
        initRegisterUser(),
      },
      child: Text(
        'Registrar usuario',
      ),
    );
  }

  initRegisterUser() {
    String name = textEditingControllerName.text.trim();
    String email = textEditingControllerEmail.text.trim() + emailDomain;
    String lastName = textEditingControllerLastName.text.trim();
    presenterRegisterUserMVP.requestModelRegisterUser(name, lastName, email);
  }
}

class _EditTextEmail extends StatelessWidget {
  final textHeight;

  _EditTextEmail(this.textHeight);

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
                    fontSize: textHeight,
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
                          fontSize: 12.sp,
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
  final textHeight;

  _EditTextNameUser(this.textHeight);

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
                  style: TextStyle(
                      color: DataSource.primaryColor, fontSize: textHeight)),
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
