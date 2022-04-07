import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppeez/recipe.dart';
import 'package:shoppeez/recipeDatabase.dart';

import 'RecipeItemWidget.dart';
import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';


class RecipeScreenBody extends StatelessWidget
{

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder<List<Recipe>>(
        future: RecipeDataBase.instance.recipes(),
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot)
        {
          if (snapshot.hasData)
          {
            List<Recipe>? recipes = snapshot.data;
            return Column(children:
            [
              Container(
                  padding: const EdgeInsets.all(8),
                  child:TextField(
                    controller: _controller, onSubmitted: (String value) async
                  {
                    await showDialog<void>(
                      context: context,
                      builder: (BuildContext context)
                      {
                        return AlertDialog(
                          title: const Text('Thanks!'),
                          content: Text('You typed "$value", which has length ${value.characters.length}.'),
                          actions: <Widget>
                          [
                          ],
                        );
                      },
                    );
                  },
                    decoration: InputDecoration(
                      hintText: 'ingredients',
                      labelText: 'What do you have to cook ? ',
                      prefixIcon: Icon(Icons.food_bank, color: Colors.red),
                      // icon: Icon(Icons.food),
                      suffixIcon: _controller.text.isEmpty
                          ? Container(width: 0):
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () =>  _controller.text ="",
                      ),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  )
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: recipes!.length,
                  itemBuilder: (context, index)
                  {
                    final recipe = recipes[index];
                    return Dismissible(key: Key(recipe.title),
                        onDismissed: (direction)
                        {
                          setState(()
                          {
                            RecipeDataBase.instance.deleteRecipe(recipe.title);
                          }
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${recipe.title} supprimé"))
                          );
                        },
                        background: Container(color: Colors.grey),
                        child: RecipeItemWidget(recipe: recipe)
                    );
                  },
                ),
              )
            ]
            );
          }
          else
          {
            return Center(child: Text("No Data"));
          }
        }
    ) ;  }

  void setState(Null Function() param0) {}
}


