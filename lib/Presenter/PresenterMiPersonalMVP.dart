//@dart=2.9

import 'package:test_login/DAO/Personal.dart';
import 'package:test_login/Model/ModelMiPersonalMVP.dart';
import 'package:test_login/View/interfaceMiPersonalMVP.dart';

class PresenterMiPersonalMVP{

  interfaceMiPersonalMVP _interfaceMiPersonalMVP;
  ModelMiPersonalMVP modelMiPersonalMVP;

  PresenterMiPersonalMVP(this._interfaceMiPersonalMVP){
    modelMiPersonalMVP=ModelMiPersonalMVP(this);
  }

  void requestModelLoadPersonal() {
    modelMiPersonalMVP.prepareModelLoadPersonal();
  }

  void notifyViewShowListPersonal(List<Personal> listPersonal) {
    _interfaceMiPersonalMVP.notifyViewShowListPersonal(listPersonal);
  }

  void notifyViewShowMsgEmptyPersonal() {
    _interfaceMiPersonalMVP.notifyViewShowMsgEmptyPersonal();
  }

  void notifyViewShowMsgError(String msgError) {
    _interfaceMiPersonalMVP.notifyViewShowMsgError(msgError);
  }

}