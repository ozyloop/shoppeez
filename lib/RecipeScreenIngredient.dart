import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shoppeez/favoriteChangeNotifier.dart';
import 'package:shoppeez/ingredientDatabase.dart';
import 'package:shoppeez/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'ShoppingListItemWidget.dart';
import 'favoriteWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeScreenIngredient extends StatelessWidget {
  RecipeScreenIngredient(this.recipe);

  final dynamic recipe;

  Future GetMethod() async
  {
    print(recipe['recipe_id']);
    print("GETMETHOD RECIPE INGREDIENT");
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/GetRecipeIngredients.php?recipe_id=" + recipe['recipe_id']);
    print("URL");
    var res = await http.get(theUrl, headers: {"Accept": "application/json"});
    print("http");
    var responsBody = json.decode(res.body);
    print("${responsBody[0]}");
    print("space2");
    return responsBody;
  }



  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
        future: GetMethod(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<dynamic>? ingredients = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text("Shoppeez"),
              ),
              body:
                              ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                 scrollDirection: Axis.vertical,
                                 shrinkWrap: true,
                                  itemCount: ingredients!.length,
                                  itemBuilder: (context, index) {
                                    final ingredient = ingredients[index];
                                    return Dismissible(
                                        key: Key(ingredient["name"]),
                                        onDismissed: (direction) {
                                          setState(() {

                                          }
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              SnackBar(content: Text(
                                                  "${ingredient
                                                      .name} supprimé"))
                                          );
                                        },
                                        background: Container(
                                            color: Colors.grey),
                                        child: ShoppingListItemWidget(ingredient)
                                    );
                                  },
                                ),






            );
          }
          else {
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
                child: Center(
                    child: Text("No Ingredients Added")));
          }
        }
    ) ;  }

  void setState(Null Function() param0) {}
}