import 'package:test_login/Model/ModelRegisterUserMVP.dart';
import 'package:test_login/View/interfaceRegisterUserMVP.dart';

class PresenterRegisterUserMVP {
  interfaceRegisterUserMVP _interface;
  ModelRegisterUserMVP? modelRegisterUserMVP;

  PresenterRegisterUserMVP(this._interface) {
    modelRegisterUserMVP = ModelRegisterUserMVP(this);
  }

  void requestModelRegisterUser(String name,String lastName, String email) {
    modelRegisterUserMVP!.prepareModelRegisterUser(name,lastName,email);
  }
}
