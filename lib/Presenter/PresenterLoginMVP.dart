
import 'package:test_login/Model/ModelLoginMVP.dart';
import 'package:test_login/View/interfaceLoginMVP.dart';

class PresenterLoginMVP {
  interfaceLoginMVP _interfaceLoginMVP;
  ModelLoginMVP? modelLoginMVP;

  PresenterLoginMVP(this._interfaceLoginMVP) {
    this.modelLoginMVP = ModelLoginMVP(this);
  }

  void requestModelValidateLogin(String email,String passwd){
    modelLoginMVP?.prepareModelValidateLogin(email,passwd);
  }

  void notifyViewShowErrorMsg(String msgError) {
    _interfaceLoginMVP.notifyViewShowErrorMsg(msgError);
  }

  void notifyViewShowInfoMsg(String msgInfo) {
    _interfaceLoginMVP.notifyViewShowInfoMsg(msgInfo);
  }

  void notifyViewShowLottieDialog() {
    _interfaceLoginMVP.notifyViewShowLottieDialog();
  }

  void notifyViewCloseLottieDialog() {
    _interfaceLoginMVP.notifyViewCloseLottieDialog();
  }

  void notifyViewShowSuccessFullLogin() {
    _interfaceLoginMVP.notifyViewShowSuccessFullLogin();
  }
}
