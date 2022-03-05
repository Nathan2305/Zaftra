import 'package:RestaurantAdmin/Presenter/PresenterRegisterUserMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';

class ModelRegisterUserMVP {
  PresenterRegisterUserMVP presenterRegisterUserMVP;

  ModelRegisterUserMVP(this.presenterRegisterUserMVP);

  void prepareModelRegisterUser(String name, String lastName, String email) {
    if (name.isNotEmpty && lastName.isNotEmpty && email.isNotEmpty) {
      presenterRegisterUserMVP.notifyViewStartLoading();
      registerUser(name, lastName, email);
    }else{
      presenterRegisterUserMVP.notifyViewEmptyFields();
    }
  }

  Future<void> registerUser(String name, String lastName, String email) async{
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
      presenterRegisterUserMVP.notifyViewShowMsgError(msgError);
    });
    if(newUser!=null){
     presenterRegisterUserMVP.notifyViewSuccessfulUserCreated(newUser);
    }
  }
}
