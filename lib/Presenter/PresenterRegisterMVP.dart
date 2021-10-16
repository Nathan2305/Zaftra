import 'package:test_login/Model/ModelRegisterMVP.dart';
import 'package:test_login/View/interfaceRegisterMVP.dart';

class PresenterRegisterMVP{
  interfaceRegisterMVP _interfaceRegisterMVP;
  ModelRegisterMVP? modelRegisterMVP;

  PresenterRegisterMVP(this._interfaceRegisterMVP){
    this.modelRegisterMVP=ModelRegisterMVP(this);
  }
  void requestModelValidateRegister(String email,String nameRes,String pass){
    modelRegisterMVP?.prepareModelValidateRegister(email,nameRes,pass);
  }

  void notifyViewShowPDialogLoading() {
    _interfaceRegisterMVP.notifyViewShowPDialogLoading();
  }

  void notifyViewEmptyField() {
    _interfaceRegisterMVP.notifyViewEmptyField();
  }

  void notifyViewClosePdialog() {
    _interfaceRegisterMVP.notifyViewClosePdialog();
  }

  void notifyViewShowErrorMsg(String msgError) {
    _interfaceRegisterMVP.notifyViewShowErrorMsg(msgError);
  }

  void notifyViewFinishRoute() {
    _interfaceRegisterMVP.notifyViewFinishRoute();
  }
}