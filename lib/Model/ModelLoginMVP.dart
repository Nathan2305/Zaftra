// @dart=2.9

import 'package:RestaurantAdmin/Presenter/PresenterLoginMVP.dart';
import 'package:RestaurantAdmin/main.dart';
import 'package:flutter/services.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

class ModelLoginMVP {
  PresenterLoginMVP presenterLoginMVP;

  ModelLoginMVP(this.presenterLoginMVP) {

  }

  void prepareModelValidateLogin(String email, String passwd) {
    if (email.isEmpty || passwd.isEmpty) {
      String msgInfo = "Debe llenar todos los campos";
      presenterLoginMVP.notifyViewShowInfoMsg(msgInfo);
    } else {
      presenterLoginMVP.notifyViewShowLottieDialog();
      Backendless.userService
          .login(email, passwd, true)
          .then((BackendlessUser backendlessUser) {
        presenterLoginMVP.notifyViewCloseLottieDialog();
        presenterLoginMVP.notifyViewShowSuccessFullLogin(backendlessUser.getObjectId());
      }).catchError((error) {
        PlatformException platformException = error;
        String msgError = platformException.message;
        presenterLoginMVP.notifyViewCloseLottieDialog();
        presenterLoginMVP.notifyViewShowErrorMsg(msgError);
      });
    }
  }
}
