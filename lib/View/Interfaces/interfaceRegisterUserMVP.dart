import 'package:backendless_sdk/backendless_sdk.dart';

abstract class interfaceRegisterUserMVP{
  void notifyViewStartLoading() {}

  void notifyViewEmptyFields() {}

  void notifyViewShowMsgError(String msgError) {}

  void notifyViewSuccessfulUserCreated(BackendlessUser backendlessUser) {}

}