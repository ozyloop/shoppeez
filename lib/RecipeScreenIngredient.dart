import 'package:flutter/material.dart';

import 'package:shoppeez/ingredientDatabase.dart';
import 'package:shoppeez/recipe.dart';

import 'ShoppingListItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';

/*
class RecipeScreenIngredient extends StatelessWidget {
  List<Ingredient> ingredients = IngredientDataBase.instance.ingredients() as List<Ingredient>;
  RecipeScreenIngredient({Key? key, required this.ingredient}) : super(key: key);

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context)
  {
    return Column(
              children:
              [
                Expanded(
                  child : ListView.builder(
                    itemCount: ingredients.length,
                    itemBuilder: (context, index)
                    {
                      final ingredient = ingredients[index];
                      return Dismissible(key: Key(ingredient.name),
                          onDismissed: (direction)
                          {

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${ingredient.name} supprimé"))
                            );
                          },
                          background: Container(color: Colors.grey),
                        //Transition to online bdd
                          //child: ShoppingListItemWidget(ingredient: ingredient)
                      );
                    },
                  ),
                )
              ]
          );
        }

      }




*/