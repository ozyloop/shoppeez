import'package:flutter/foundation.dart';
import 'package:shoppeez/ingredient.dart';

import 'package:shoppeez/ingredientDatabase.dart';

import 'ingredientDatabase.dart';

class QuantityChangeNotifier with ChangeNotifier {
  Ingredient ingredient;


  QuantityChangeNotifier(this.ingredient);



  int get ingredientquantity => ingredient.quantity ;
  notifyListeners();

}