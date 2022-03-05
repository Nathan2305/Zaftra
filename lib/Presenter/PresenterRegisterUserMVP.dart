import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:RestaurantAdmin/Model/ModelRegisterUserMVP.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceRegisterUserMVP.dart';

class PresenterRegisterUserMVP {
  interfaceRegisterUserMVP _interface;
  ModelRegisterUserMVP? modelRegisterUserMVP;

  PresenterRegisterUserMVP(this._interface) {
    modelRegisterUserMVP = ModelRegisterUserMVP(this);
  }

  void requestModelRegisterUser(String name,String lastName, String email) {
    modelRegisterUserMVP!.prepareModelRegisterUser(name,lastName,email);
  }

  void notifyViewStartLoading() {
    _interface.notifyViewStartLoading();
  }

  void notifyViewEmptyFields() {
    _interface.notifyViewEmptyFields();
  }

  void notifyViewShowMsgError(String msgError) {
    _interface.notifyViewShowMsgError(msgError);
  }

  void notifyViewSuccessfulUserCreated( BackendlessUser backendlessUser) {
    _interface.notifyViewSuccessfulUserCreated(backendlessUser);
  }
}
