// @dart=2.9

import 'package:RestaurantAdmin/Presenter/PresenterMainMenuMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';


class ModelMainMenuMVP{
  static BackendlessUser currentUser;
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

  void prepareModelShowFields(String objectId) {
    setCurrentUser(objectId);
  }

  Future<void> setCurrentUser(String objectId) async {
    currentUser = await Backendless.userService.getCurrentUser();
    if(currentUser==null){
      currentUser=await Backendless.userService.findById(objectId);
    }
    String businessName = currentUser.getProperty(DataSource.COLUMN_NAME_RESTAURANT).toString();
    presenterMainMenuMVP.notifyViewShowFields(businessName);
  }
}