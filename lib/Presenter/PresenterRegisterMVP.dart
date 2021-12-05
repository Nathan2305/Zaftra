import 'package:test_login/Model/ModelRegisterAdminMVP.dart';
import 'package:test_login/View/interfaceRegisterMVP.dart';

class PresenterRegisterMVP{
  interfaceRegisterMVP _interfaceRegisterMVP;
  ModelRegisterMVP? modelRegisterMVP;

  PresenterRegisterMVP(this._interfaceRegisterMVP){
    this.modelRegisterMVP=ModelRegisterMVP(this);
  }
  void requestModelValidateRegister(String email,String nameAdmin,String nameRes,String pass){
    modelRegisterMVP?.prepareModelValidateRegister(email,nameAdmin,nameRes,pass);
  }

  void notifyViewShowPDialogLoading() {
    _interfaceRegisterMVP.notifyViewShowPDialogLoading();
  }

  void notifyViewEmptyField() {
    _interfaceRegisterMVP.notifyViewEmptyField();
  }

  void notifyViewCloseProgressDialog() {
    _interfaceRegisterMVP.notifyViewCloseProgressDialog();
  }

  void notifyViewShowErrorMsg(String msgError) {
    _interfaceRegisterMVP.notifyViewShowErrorMsg(msgError);
  }

  void notifyViewFinishRoute() {
    _interfaceRegisterMVP.notifyViewFinishRoute();
  }
}