// @dart=2.9

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:test_login/Presenter/PresenterMainMenuMVP.dart';

class ModelMainMenuMVP{
  PresenterMainMenuMVP presenterMainMenuMVP;
  ModelMainMenuMVP(this.presenterMainMenuMVP);

  void prepareModelLogOut() {
    logOutUser();
  }

  Future<void> logOutUser() async{
    Backendless.userService.logout().then((value) => {
      presenterMainMenuMVP.notifySuccessfulLogOut()
    }).catchError((onError) {
      PlatformException exception = onError;
      String msgError = 'Error cerrando sesión de usuario:" $exception';
    });
  }

}