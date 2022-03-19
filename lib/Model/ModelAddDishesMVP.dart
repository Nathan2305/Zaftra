// @dart=2.9
import 'package:RestaurantAdmin/DAO/Dishes.dart';
import 'package:RestaurantAdmin/Presenter/PresenterAddDishesMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';

class ModelAddDishesMVP {
  PresenterAddDishesMVP presenterAddDishesMVP;

  ModelAddDishesMVP(this.presenterAddDishesMVP);

  void prepareModelRegisterDish(String nameDishTxt, String priceDishTxt,
      String descDishTxt,String category) {
    if (nameDishTxt.isEmpty || priceDishTxt.isEmpty || descDishTxt.isEmpty) {
      presenterAddDishesMVP.notifyViewEmptyFields();
    } else {
      presenterAddDishesMVP.notifyViewStartLoadingWidget();
      Dishes dishes = Dishes();
      dishes.name = nameDishTxt;
      dishes.price = double.parse(priceDishTxt);
      dishes.description = descDishTxt;
      dishes.category=category;
      registerDish(dishes);
    }
  }

  Future<void> registerDish(Dishes dish) async {
    bool containError = false;
    Dishes dishCreated = await Backendless.data
        .withClass<Dishes>()
        .save(dish)
        .catchError((onError) {
      containError = true;
      PlatformException platformException = onError;
      String msgError = "Error registrando nuevo plato: ${platformException.details}";
      presenterAddDishesMVP.notifyViewCloseLoadingWidget();
      presenterAddDishesMVP.notifyViewShowMsgInfo("error", msgError);
    });
    if (!containError) {
      presenterAddDishesMVP.notifyViewCloseLoadingWidget();
      if (dishCreated != null) {
        presenterAddDishesMVP.notifyViewDishCreatedSuccessfully(dishCreated);
      }
    }
  }
}
