import 'package:backendless_sdk/backendless_sdk.dart';

@reflector
class Personal{
  String objectId;
  String name;
  String lastName;

  Personal(this.objectId,this.name,this.lastName);

  String get getNamePersonal{
    return name;
  }

  String get getObjectIdPersonal{
    return objectId;
  }

  String get getLastNamePersonal{
    return lastName;
  }

  void set setName(String newName){
    name=newName;
  }

  void set setLastName(String newLastName){
    lastName=newLastName;
  }
}