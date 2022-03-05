abstract class interfaceDishesMVP{
  void notifyViewEmptyDishes() {}

  void notifyViewShowDishes() {}

  void notifyViewShowMessage(String msgType, String msgError) {}

  void notifyViewStartLoadingWidget() {}

  void notifyViewCloseLoadingWidget() {}

  void notifyViewShowDishesAmount(int amountDishes) {}

}