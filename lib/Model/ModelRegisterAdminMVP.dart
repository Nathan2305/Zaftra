// @dart=2.9

import 'package:RestaurantAdmin/Presenter/PresenterRegisterAdminMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';

class ModelRegisterMVP {
  PresenterRegisterAdminMVP presenterRegisterAdminMVP;

  ModelRegisterMVP(this.presenterRegisterAdminMVP);

  void prepareModelValidateRegister(
      String businessName, String owner, String email, String passwd) {
    if (businessName.isNotEmpty &&
        owner.isNotEmpty &&
        email.isNotEmpty &&
        passwd.isNotEmpty) {
      presenterRegisterAdminMVP.notifyViewShowPDialogLoading();
      BackendlessUser user = BackendlessUser();
      user.email = email;
      user.password = passwd;
      user.setProperty(DataSource.COLUMN_PROFILE, "admin");
      user.setProperty(DataSource.COLUMN_NAME_RESTAURANT, businessName);
      user.setProperty(DataSource.COLUMN_NAME, owner);
      registerUser(user);
    } else {
      presenterRegisterAdminMVP.notifyViewEmptyField();
    }
  }

  Future<void> registerUser(BackendlessUser user) async {
    BackendlessUser newAdminCreated = await Backendless.userService.register(user).catchError((onError) {
      PlatformException exception = onError;
      String msgError = 'Error registrando usuario:'+exception.message;
      presenterRegisterAdminMVP.notifyViewCloseProgressDialog();
      presenterRegisterAdminMVP.notifyViewShowErrorMsg(msgError);
    });
    if (newAdminCreated != null) {
            presenterRegisterAdminMVP.notifyViewCloseProgressDialog();
            presenterRegisterAdminMVP.notifyViewSuccessfulAdminsCreated();
      presenterRegisterAdminMVP.notifyViewFinishRoute();
    }
  }
}
