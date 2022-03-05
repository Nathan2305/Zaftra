

import 'package:RestaurantAdmin/Model/ModelRegisterAdminMVP.dart';

import '../View/Interfaces/interfaceRegisterAdminMVP.dart';

class PresenterRegisterAdminMVP{
  interfaceRegisterAdminMVP _interfaceRegisterAdminMVP;
  ModelRegisterMVP? modelRegisterMVP;

  PresenterRegisterAdminMVP(this._interfaceRegisterAdminMVP){
    this.modelRegisterMVP=ModelRegisterMVP(this);
  }
  void requestModelValidateRegister(String businessName,String owner,String email,String passwd){
    modelRegisterMVP?.prepareModelValidateRegister(businessName,owner,email,passwd);
  }

  void notifyViewShowPDialogLoading() {
    _interfaceRegisterAdminMVP.notifyViewShowPDialogLoading();
  }

  void notifyViewEmptyField() {
    _interfaceRegisterAdminMVP.notifyViewEmptyField();
  }

  void notifyViewCloseProgressDialog() {
    _interfaceRegisterAdminMVP.notifyViewCloseProgressDialog();
  }

  void notifyViewShowErrorMsg(String msgError) {
    _interfaceRegisterAdminMVP.notifyViewShowErrorMsg(msgError);
  }

  void notifyViewFinishRoute() {
    _interfaceRegisterAdminMVP.notifyViewFinishRoute();
  }

  void notifyViewSuccessfulAdminsCreated() {
    _interfaceRegisterAdminMVP.notifyViewSuccessfulAdminsCreated();
  }
}