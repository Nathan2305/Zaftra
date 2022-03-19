//@dart=2.9
import 'package:RestaurantAdmin/DAO/Dishes.dart';
import 'package:RestaurantAdmin/Model/ModelMainMenuMVP.dart';
import 'package:RestaurantAdmin/Presenter/PresenterDishesMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class ModelDishesMVP {
  PresenterDishesMVP presenterDishesMVP;

  ModelDishesMVP(this.presenterDishesMVP);

  List<Dishes> fullListDishes = List();

  Future<List<Dishes>> prepareModelLoadMyDishes(String category) {
    var myOwnerId = ModelMainMenuMVP.currentUser.getObjectId();
    DataQueryBuilder dataQueryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId='${myOwnerId}' and category='${category}'"
      ..sortBy = ["created DESC"]
      ..pageSize = 10
      ..offset = 0;

    loadMyDishes(dataQueryBuilder);


    return Future.value(fullListDishes);
  }

  void loadMyDishes(DataQueryBuilder dataQueryBuilder) async {
    List<Dishes> listDishes = await Backendless.data
        .withClass<Dishes>()
        .find(dataQueryBuilder)
        .catchError((OnError) {

    });
    if (listDishes!=null && listDishes.isNotEmpty) {
      fullListDishes.addAll(listDishes);
      dataQueryBuilder.prepareNextPage();
      loadMyDishes(dataQueryBuilder);
    }
  }
}
