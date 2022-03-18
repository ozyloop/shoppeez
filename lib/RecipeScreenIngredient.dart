import 'package:flutter/material.dart';

import 'package:shoppeez/ingredientDatabase.dart';
import 'package:shoppeez/recipe.dart';

import 'ingredient.dart';
import 'ingredientDatabase.dart';


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
                          child: ShoppingListItemWidget(ingredient: ingredient)
                      );
                    },
                  ),
                )
              ]
          );
        }

      }





class ShoppingListItemWidget extends StatelessWidget
{
  const ShoppingListItemWidget({Key? key, required this.ingredient}) : super(key: key);
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context)
  {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
            Container(
                alignment: Alignment.center,
                child: Row(
                    children:
                    [
                      Hero(
                          tag: "imageIngredient" + ingredient.name,
                          child: Image.asset(
                            ingredient.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                              children:
                              [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                          ingredient.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          )
                                      ),
                                    ),
                                    Text(
                                        ingredient.type,
                                        style: TextStyle(
                                            color: Colors.grey[500], fontSize: 16)
                                    )
                                  ],
                                ),
                              ]
                          )
                      )
                    ]
                )
            ),
            Row(
                children:
                [
                  Text(ingredient.quantity.toString()),
                  Text(" "+ingredient.quantityType),
                  IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.red,
                      onPressed: () => print("works")
                  ),
                ]
            )
          ]
      ),
    );
  }
}