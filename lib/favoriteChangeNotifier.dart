import'package:flutter/foundation.dart';
import 'package:shoppeez/recipe.dart';
import 'package:shoppeez/recipeDatabase.dart';

class FavoriteChangeNotifier with ChangeNotifier {
  Recipe recipe;


  FavoriteChangeNotifier(this.recipe);

  bool get isFavorited => recipe.isFavorite;

  int get favoriteCount => recipe.favoriteCount + (recipe.isFavorite ? 1 : 0);

  set isFavorited(bool isFavorited) {
    recipe.isFavorite = isFavorited;
    RecipeDataBase.instance.updateRecipe(recipe);
    notifyListeners();
  }
}