//@dart=2.9
import 'package:RestaurantAdmin/DAO/Dishes.dart';
import 'package:RestaurantAdmin/Model/ModelListDishesMVP.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceDishesMVP.dart';

class PresenterDishesMVP {
  interfaceDishesMVP _interfaceDishesMVP;
  ModelDishesMVP modelDishesMVP;

  PresenterDishesMVP(this._interfaceDishesMVP) {
    modelDishesMVP = ModelDishesMVP(this);
  }

  Future<List<Dishes>> requestModelLoadMyDishes(String category) {
    return modelDishesMVP?.prepareModelLoadMyDishes(category);
  }

  void notifyViewEmptyDishes() {
    _interfaceDishesMVP.notifyViewEmptyDishes();
  }

  void notifyViewShowDishes() {
    _interfaceDishesMVP.notifyViewShowDishes();
  }

  void notifyViewShowMessage(String msgType, String msgError) {
    _interfaceDishesMVP.notifyViewShowMessage(msgType,msgError);
  }

  void notifyViewStartLoadingWidget() {
    _interfaceDishesMVP.notifyViewStartLoadingWidget();
  }

  void notifyViewCloseLoadingWidget() {
    _interfaceDishesMVP.notifyViewCloseLoadingWidget();
  }

  void notifyViewShowDishesAmount(int amountDishes) {
    _interfaceDishesMVP.notifyViewShowDishesAmount(amountDishes);
  }
}
