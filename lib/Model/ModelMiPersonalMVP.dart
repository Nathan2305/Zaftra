//@dart=2.9

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:test_login/DAO/Personal.dart';
import 'package:test_login/Presenter/PresenterMiPersonalMVP.dart';

import '../main.dart';

class ModelMiPersonalMVP {
  PresenterMiPersonalMVP presenterMiPersonalMVP;

  ModelMiPersonalMVP(this.presenterMiPersonalMVP);

  Future<void> prepareModelLoadPersonal() async{
      DataQueryBuilder dataQueryBuilder=DataQueryBuilder();
      var ownerId=MyAppMain.currentUser.getObjectId();
      var myEmail=MyAppMain.currentUser.email;
      dataQueryBuilder..whereClause="ownerId='${ownerId}' and email!='${myEmail}'";
      List<BackendlessUser> listPersonal= await Backendless.data.withClass<BackendlessUser>().find(dataQueryBuilder).catchError((error) {
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
