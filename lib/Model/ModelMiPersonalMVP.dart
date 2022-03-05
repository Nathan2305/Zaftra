//@dart=2.9

import 'package:RestaurantAdmin/Presenter/PresenterMiPersonalMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class ModelMiPersonalMVP {
  List<BackendlessUser> listTotalPersonal = List<BackendlessUser>();

  PresenterMiPersonalMVP presenterMiPersonalMVP;

  ModelMiPersonalMVP(this.presenterMiPersonalMVP);

  void prepareModelLoadPersonal() {
    var myOwnerId = MyAppMain.currentUser.getObjectId();
    DataQueryBuilder dataQueryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId='${myOwnerId}' and profile='worker'"
      ..sortBy=["created DESC"]
      ..pageSize = 10
      ..offset = 0;
    getWorkers(dataQueryBuilder);
  }

  Future<void> getWorkers(DataQueryBuilder dataQueryBuilder) async {
    List<BackendlessUser> listPersonal = await Backendless.data
        .withClass<BackendlessUser>()
        .find(dataQueryBuilder)
        .catchError((error) {
      PlatformException exception = error;
      String msgError = 'Error cargando trabajadores: ${exception.message}';
      presenterMiPersonalMVP.notifyViewShowMsgError(msgError);
    });
    if (listPersonal != null && listPersonal.isNotEmpty) {
      listTotalPersonal.addAll(listPersonal);
      dataQueryBuilder.prepareNextPage();
      getWorkers(dataQueryBuilder);
    } else {
      if (listTotalPersonal.isEmpty) {
        presenterMiPersonalMVP.notifyViewShowMsgEmptyPersonal();
      } else {
        presenterMiPersonalMVP.notifyViewShowListPersonal(listTotalPersonal);
      }
    }
  }
}
