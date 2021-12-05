// @dart=2.9

import 'package:flutter/services.dart';
import 'package:test_login/Presenter/PresenterLoginMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:test_login/main.dart';

class ModelLoginMVP {
  PresenterLoginMVP presenterLoginMVP;

  ModelLoginMVP(this.presenterLoginMVP) {
    Backendless.initApp(
        applicationId: "C53D7BF1-EC61-A11B-FF18-31BAED0CB500",
        androidApiKey: "DB303CEE-4604-43D7-8FE6-D8ACA6B45FF5",
        iosApiKey: "C8E9E135-C284-49C9-BFFC-CC95F85705A1");
  }

  void prepareModelValidateLogin(String email, String passwd) {
    if (email.isEmpty || passwd.isEmpty) {
      String msgInfo = "Debe llenar todos los campos";
      presenterLoginMVP.notifyViewShowInfoMsg(msgInfo);
    } else {
      presenterLoginMVP.notifyViewShowLottieDialog();
      Backendless.userService.login(email, passwd, true).then((BackendlessUser backendlessUser) {
        MyAppMain.currentUser=backendlessUser;
        presenterLoginMVP.notifyViewCloseLottieDialog();
        presenterLoginMVP.notifyViewShowSuccessFullLogin();
      }).catchError((error) {
        PlatformException platformException = error;
        String msgError = platformException.message;
        presenterLoginMVP.notifyViewCloseLottieDialog();
        presenterLoginMVP.notifyViewShowErrorMsg(msgError);
      });
    }
  }
}
