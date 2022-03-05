import 'package:backendless_sdk/backendless_sdk.dart';

abstract class interfaceMiPersonalMVP{
  void notifyViewShowListPersonal(List<BackendlessUser> listPersonal) {}

  void notifyViewShowMsgEmptyPersonal() {}

  void notifyViewShowMsgError(String msgError) {}

}