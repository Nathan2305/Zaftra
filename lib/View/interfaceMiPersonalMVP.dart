import 'package:test_login/DAO/Personal.dart';

abstract class interfaceMiPersonalMVP{
  void notifyViewShowListPersonal(List<Personal> listPersonal) {}

  void notifyViewShowMsgEmptyPersonal() {}

  void notifyViewShowMsgError(String msgError) {}

}