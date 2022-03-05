//@dart=2.9

import 'package:RestaurantAdmin/Model/ModelMiPersonalMVP.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceMiPersonalMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';


class PresenterMiPersonalMVP{

  interfaceMiPersonalMVP _interfaceMiPersonalMVP;
  ModelMiPersonalMVP modelMiPersonalMVP;

  PresenterMiPersonalMVP(this._interfaceMiPersonalMVP){
    modelMiPersonalMVP=ModelMiPersonalMVP(this);
  }

  void requestModelLoadPersonal() {
    modelMiPersonalMVP.prepareModelLoadPersonal();
  }

  void notifyViewShowListPersonal(List<BackendlessUser> listPersonal) {
    _interfaceMiPersonalMVP.notifyViewShowListPersonal(listPersonal);
  }

  void notifyViewShowMsgEmptyPersonal() {
    _interfaceMiPersonalMVP.notifyViewShowMsgEmptyPersonal();
  }

  void notifyViewShowMsgError(String msgError) {
    _interfaceMiPersonalMVP.notifyViewShowMsgError(msgError);
  }

}