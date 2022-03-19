//@dart=2.9

import 'dart:async';

//import 'dart:html';
import 'dart:io';
import 'package:RestaurantAdmin/Model/ModelMainMenuMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:RestaurantAdmin/Presenter/PresenterRegisterUserMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
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
Widget childButton = Text(
  'Registrar usuario',
);

class RegisterNewPersonalScreen extends StatelessWidget {
  RegisterNewPersonalScreen();

  final nameRest = ModelMainMenuMVP.currentUser
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
          //extendBodyBehindAppBar: true,
          appBar: AppBar(
              centerTitle: true,
              //elevation: 0,
              backgroundColor: DataSource.primaryColorPersonal,
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

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    presenterRegisterUserMVP = PresenterRegisterUserMVP(this);
    outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
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
        child: AbsorbPointer(
          absorbing: showLoadingProgress,
          child: Opacity(
            opacity: opacity,
            child: Container(
              alignment: Alignment.center,
              height: 100.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  DataSource.primaryColorPersonal,
                  DataSource.secondaryColorPersonal
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _EditTextEmail(12.sp),
                    _EditTextNameUser(12.sp),
                    _EditTextLastNameUser(12.sp),
                    ButtonRegistrar(),
                  ],
                ),
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
      childButton=Container(
        color: Colors.transparent,
        width: 50.w,
        height: 3.5.h,
        child: SpinKitCircle(
          color: Colors.white,
          size: 3.5.h,
        ),
      );
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
      childButton = Text(
        'Registrar usuario',
      );
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
      childButton = Text(
        'Registrar usuario',
      );
      showLoadingProgress = false;
      opacity = 1.0;
    });
    textEditingControllerLastName.clear();
    textEditingControllerEmail.clear();
    textEditingControllerName.clear();
    var snackBar = SnackBar(
        content:
            Text("Se creó el usuario " + nameUserCreated + " correctamente"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (listWorkers == null || listWorkers.isEmpty) {
      listWorkers = List();
    }
    listWorkers.add(newBackendlessUserCreated);
    // Navigator.pop(context,listWorkers);
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
                  style: TextStyle(color: Colors.white, fontSize: textHeight)),
            ),
            TextField(
                cursorColor: Colors.white,
                controller: textEditingControllerLastName,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    // height: aspectRatio,
                    color: Colors.white,
                    fontSize: 17,
                    decorationColor: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ))
          ],
        ));
  }
}

class ButtonRegistrar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 50.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: DataSource.primaryColorPersonal,
            elevation: 10,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            textStyle: TextStyle(fontSize: 20)),
        onPressed: () => {
          initRegisterUser(),
        },
        child: childButton,
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
                    color: Colors.white,
                    fontSize: textHeight,
                  )),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                      autofocus: true,
                      cursorColor: Colors.white,
                      controller: textEditingControllerEmail,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 12.sp,
                          decorationColor: Colors.white,
                          color: Colors.white),
                      decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white, fontSize: textHeight)),
            ),
            TextField(
                cursorColor: Colors.white,
                controller: textEditingControllerName,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    decorationColor: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ))
          ],
        ));
  }
}
