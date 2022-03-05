// @dart=2.9

import 'package:backendless_sdk/backendless_sdk.dart';

@reflector
class Dishes {
  String category;
  String name;
  double price;
  String description;

  Dishes() {}

  String get getCategory {
    return category;
  }

  String get getName {
    return name;
  }

  double get getPrice {
    return price;
  }

  String get getDescription {
    return description;
  }

  void set setDescription(String newDescription) {
    description = newDescription;
  }

  void set setCategory(String newCategory) {
    category = newCategory;
  }

  void set setName(String newName) {
    name = newName;
  }

  void set setPrice(double newPrice) {
    price = newPrice;
  }
}
