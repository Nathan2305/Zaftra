import 'package:RestaurantAdmin/DAO/Dishes.dart';

abstract class interfaceAddDishesMVP{
  void notifyViewShowMsgInfo(String msgType, String msgError) {}

  void notifyViewEmptyFields() {}

  void notifyViewStartLoadingWidget() {}

  void notifyViewCloseLoadingWidget() {}

  void notifyViewDishCreatedSuccessfully(Dishes dishCreated) {}

}