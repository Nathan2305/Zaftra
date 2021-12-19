//@dart=2.9

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:test_login/DAO/Personal.dart';
import 'package:test_login/Presenter/PresenterMiPersonalMVP.dart';

class ModelMiPersonalMVP {
  PresenterMiPersonalMVP presenterMiPersonalMVP;

  ModelMiPersonalMVP(this.presenterMiPersonalMVP);

  void prepareModelLoadPersonal() async{
    List<Personal> listPersonal= await Backendless.data.withClass<Personal>().find().catchError((error) {
      PlatformException exception = error;
      String msgError = 'Error cargando trabajadores: ${exception.message}';
      presenterMiPersonalMVP.notifyViewShowMsgError(msgError);
    });
    if (listPersonal != null && listPersonal.isNotEmpty) {
      presenterMiPersonalMVP.notifyViewShowListPersonal(listPersonal);
    } else {
      presenterMiPersonalMVP.notifyViewShowMsgEmptyPersonal();
    }
  }
}
