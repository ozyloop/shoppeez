import 'dart:ffi';

import'package:flutter/foundation.dart';
import 'package:shoppeez/recipe.dart';
import 'package:shoppeez/recipeDatabase.dart';

class FavoriteChangeNotifier with ChangeNotifier {
  FavoriteChangeNotifier(this.recipe);
  final dynamic recipe;

  @override
  bool TestFavorite(dynamic recipe)
  {
    if(recipe["fk_customer_id"]==null)
    {
      return false;
    }
    else
      {
        return true;
      }
  }


}