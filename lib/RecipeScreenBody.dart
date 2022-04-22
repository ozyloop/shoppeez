import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppeez/recipe.dart';
import 'package:shoppeez/recipeDatabase.dart';

import 'RecipeItemWidget.dart';
import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RecipeScreenBody extends StatelessWidget
{

  final TextEditingController _controller = TextEditingController();
  @override
  Future GetMethod() async
  {
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/GetRecipe.php");
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);
    return responsBody;
  }


//https://shoppeaz.000webhostapp.com/AddRecipeIngredients.php?customer_id=4&recipe_id=5
  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
        future: GetMethod(),
        builder: (BuildContext context, AsyncSnapshot snapshot)
        {
          if (snapshot.hasData)
          {
            List<dynamic>? recipes = snapshot.data;
            return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
        child: Column(children:
            [
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1860BA),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.all(8),
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

                      hintText: 'What do you want to cook ? ',

                      hintStyle: TextStyle(
                        color: Color(0xFF2FE3CB),
                        fontFamily: 'OpenSans',
                      ),

                      prefixIcon: Icon(Icons.food_bank, color: Color(0xFF2FE3CB)),
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
                    return Dismissible(key: Key(recipe["name"]),
                        onDismissed: (direction)
                        {
                          setState(()
                          {

                          }
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${recipe.title} supprimé"))
                          );
                        },
                        background: Container(color: Colors.grey),
                        child: RecipeItemWidget(recipe)
                    );
                  },
                ),
              )
            ]
            ));
          }
          else
          {
            return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
                child:Center(
                    child: Text("Loading")));
          }
        }
    ) ;  }

  void setState(Null Function() param0) {}
}


