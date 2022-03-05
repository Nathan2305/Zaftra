import 'package:RestaurantAdmin/DAO/Dishes.dart';
import 'package:RestaurantAdmin/Model/ModelAddDishesMVP.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceAddDishesMVP.dart';

class PresenterAddDishesMVP{
  interfaceAddDishesMVP _interfaceAddDishesMVP;
  ModelAddDishesMVP? modelAddDishesMVP;

  PresenterAddDishesMVP(this._interfaceAddDishesMVP){
    modelAddDishesMVP=ModelAddDishesMVP(this);
  }

  void requestModelRegisterDish(String nameDishTxt, String priceDishTxt, String descDishTxt,String category) {
    modelAddDishesMVP?.prepareModelRegisterDish(nameDishTxt,priceDishTxt,descDishTxt,category);
  }

  void notifyViewShowMsgInfo(String msgType, String msgError) {
    _interfaceAddDishesMVP.notifyViewShowMsgInfo(msgType,msgError);
  }

  void notifyViewEmptyFields() {
    _interfaceAddDishesMVP.notifyViewEmptyFields();
  }

  void notifyViewStartLoadingWidget() {
    _interfaceAddDishesMVP.notifyViewStartLoadingWidget();
  }

  void notifyViewCloseLoadingWidget() {
    _interfaceAddDishesMVP.notifyViewCloseLoadingWidget();
  }

  void notifyViewDishCreatedSuccessfully(Dishes dishCreated) {
    _interfaceAddDishesMVP.notifyViewDishCreatedSuccessfully(dishCreated);
  }
}