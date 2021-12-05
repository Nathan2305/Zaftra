class Personal{
  String objectId;
  String name;
  String lastName;

  Personal(this.objectId,this.name,this.lastName);

  String get namePersonal{
    return name;
  }

  String get objectIdPersonal{
    return objectId;
  }

  String get lastNamePersonal{
    return lastName;
  }

  void set setName(String newName){
    name=newName;
  }

  void set setLastName(String newLastName){
    lastName=newLastName;
  }
}