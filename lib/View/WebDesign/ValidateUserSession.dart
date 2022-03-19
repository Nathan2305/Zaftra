// @dart=2.9
import 'dart:async';

import 'package:RestaurantAdmin/Model/ModelMainMenuMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:RestaurantAdmin/View/WebDesign/MainMenuWeb.dart';

import '../../main.dart';
import 'LoginLayoutWeb.dart';

void main() {
  runApp(ValidateUserSession());
}

class ValidateUserSession extends StatefulWidget {
  _ValidateUserSession createState() => _ValidateUserSession();
}

class _ValidateUserSession extends State<ValidateUserSession> {
  bool finishValidating = false;
  var targetWidget;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (!finishValidating) {
      Future.delayed(
        Duration(seconds: 4),
        () {
          validateSession();
        },
      );
    }
    return !finishValidating ? SpinkitLoading() : targetWidget;
  }

  Future<void> validateSession() async {
    Map<dynamic, dynamic> mapUser;
    String objectId =await Backendless.userService.loggedInUser().catchError((onError) {
      PlatformException exception = onError;
      var msgError = 'Error obteniendo sesión de usuario:" $exception';
      print('Error: ' + msgError);
    });
    if (objectId != null && objectId.isNotEmpty) {
      mapUser = (await Backendless.data
          .of("Users")
          .findById(objectId)
          .catchError((onError) {
        PlatformException exception = onError;
        //msgError = 'Error obteniendo sesión de usuario:" $exception';
      }));
      if (mapUser != null) {
        ModelMainMenuMVP.currentUser = BackendlessUser.fromJson(mapUser);
        finishValidating = true;
        targetWidget = MainMenuWeb();
      }
    } else {
      //go to login page
      setState(() {
        finishValidating = true;
        targetWidget = LoginLayoutWeb();
      });
    }
  }
}

class SpinkitLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SpinKitCircle(
      color: Colors.blue,
      size: 20.w,
    );
  }
}
