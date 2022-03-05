import 'package:RestaurantAdmin/DAO/Dishes.dart';
import 'package:RestaurantAdmin/Presenter/PresenterDishesMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class ModelDishesMVP {
  PresenterDishesMVP presenterDishesMVP;

  ModelDishesMVP(this.presenterDishesMVP);

  void prepareModelLoadMyDishes(String category) {
    presenterDishesMVP.notifyViewStartLoadingWidget();
    var myOwnerId = MyAppMain.currentUser.getObjectId();
    DataQueryBuilder dataQueryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId='${myOwnerId}' and category='${category}'";
    dataQueryBuilder.offset = 0;
    dataQueryBuilder.pageSize = 10;
    loadMyDishes(dataQueryBuilder);
  }

  Future<void> loadMyDishes(DataQueryBuilder dataQueryBuilder) async {
    bool error = false;
    var listDishes = await Backendless.data
        .withClass<Dishes>()
        .find(dataQueryBuilder)
        .catchError((error) {
      error = true;
      PlatformException exception = error;
      String msgError = 'Error mostrando platos: ${exception.message}';
      presenterDishesMVP.notifyViewCloseLoadingWidget();
      presenterDishesMVP.notifyViewShowMessage("error", msgError);
    });
    if (!error) {
      if (listDishes != null && listDishes.length > 0) {
        presenterDishesMVP.notifyViewShowDishes();
        presenterDishesMVP.notifyViewShowDishesAmount(listDishes.length);
      } else {
        presenterDishesMVP.notifyViewEmptyDishes();
        presenterDishesMVP.notifyViewShowDishesAmount(0);
      }
    }
  }
}
