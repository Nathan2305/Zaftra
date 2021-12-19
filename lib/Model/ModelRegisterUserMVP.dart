import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:test_login/Presenter/PresenterRegisterUserMVP.dart';
import 'package:test_login/Utils/DataSource.dart';

class ModelRegisterUserMVP {
  PresenterRegisterUserMVP presenterRegisterUserMVP;

  ModelRegisterUserMVP(this.presenterRegisterUserMVP);

  void prepareModelRegisterUser(String name, String lastName, String email) {
    if (name.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty) {
      registerUser(name, lastName, email);
    }
  }

  void registerUser(String name, String lastName, String email) async{
    BackendlessUser backendlessUser = BackendlessUser();
    backendlessUser.email = email;
    backendlessUser.password = 'restaurant123';
    backendlessUser.setProperty(DataSource.COLUMN_NAME, name);
    backendlessUser.setProperty(DataSource.COLUMN_LAST_NAME, lastName);
    backendlessUser.setProperty(DataSource.COLUMN_PROFILE, "worker");
    backendlessUser.setProperty(DataSource.COLUMN_NAME_RESTAURANT, "null");
    BackendlessUser? newUser= await Backendless.userService.register(backendlessUser).catchError((error) {
      PlatformException exception = error;
      String msgError = 'Error registrando nuevo usuario: ${exception.message}';
      //presenterRegisterUserMVP.notifyViewShowMsgError(msgError);
    });
    if(newUser!=null){
      print('new user registered');
    }
  }
}
