// @dart=2.9



import 'package:RestaurantAdmin/Model/ModelMainMenuMVP.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceMainMenuMVP.dart';

class PresenterMainMenuMVP{
  interfaceMainMenuMVP _interfaceMainMenuMVP;
  ModelMainMenuMVP _modelMainMenuMVP;

  PresenterMainMenuMVP(this._interfaceMainMenuMVP) {
    this._modelMainMenuMVP = ModelMainMenuMVP(this);
  }

  void requestModelLogOut() {
    _modelMainMenuMVP.prepareModelLogOut();
  }

  notifySuccessfulLogOut() {
    _interfaceMainMenuMVP.notifySuccessfulLogOut();
  }
}