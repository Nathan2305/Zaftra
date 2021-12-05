// @dart=2.9

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:test_login/Presenter/PresenterRegisterMVP.dart';
import 'package:test_login/Utils/DataSource.dart';

class ModelRegisterMVP {
  PresenterRegisterMVP presenterRegisterMVP;

  ModelRegisterMVP(this.presenterRegisterMVP);

  void prepareModelValidateRegister(String emailUser,String nameAdmin, String nameResUser, String passUser) {
    if (emailUser.isNotEmpty && nameAdmin.isNotEmpty && nameResUser.isNotEmpty && passUser.isNotEmpty) {
      presenterRegisterMVP.notifyViewShowPDialogLoading();
      BackendlessUser user = BackendlessUser();
      user.email = emailUser;
      user.password = passUser;
      user.setProperty(DataSource.COLUMN_PROFILE, "admin");
      user.setProperty(DataSource.COLUMN_NAME_RESTAURANT, nameResUser);
      user.setProperty(DataSource.COLUMN_NAME, nameAdmin);
      registerUser(user);
    } else {
      presenterRegisterMVP.notifyViewEmptyField();
    }
  }

  void registerUser(BackendlessUser user) {
    Backendless.userService.register(user).then((BackendlessUser backendlessUser) {
      presenterRegisterMVP.notifyViewCloseProgressDialog();
      presenterRegisterMVP.notifyViewFinishRoute();
    }).catchError((error) {
      PlatformException exception = error;
      String msgError = 'Error registrando usuario: $exception.message';
      presenterRegisterMVP.notifyViewCloseProgressDialog();
      presenterRegisterMVP.notifyViewShowErrorMsg(msgError);
    });
  }
}
