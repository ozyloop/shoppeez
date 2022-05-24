import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppeez/BddController.dart';
import 'package:shoppeez/recipeDatabase.dart';

import 'RecipeScreenIngredient.dart';
import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ShoppingListItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ShoppingScreenBody extends StatelessWidget
{

  final TextEditingController _controller = TextEditingController();
  @override
  Future GetMethod() async
  {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id') ;
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/ShoppingListItems.php?id=" + id.toString());
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);

    return responsBody;
  }

  @override
  void DeleteIngredient(String name) async
  {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id') ;
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/DeleteIngredientShoppingList.php?name=" + name+"&customer_id=" +id.toString());
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);
  }
  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
        future: GetMethod(),
        builder: (context, AsyncSnapshot snapshot)
        {
          if (snapshot.hasData)
          {
            List<dynamic>? ingredients = snapshot.data;
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
            child: Column(
                children:
                [
                  Expanded(
                    child : ListView.builder(
                      itemCount: ingredients!.length,
                      itemBuilder: (context, index)
                      {
                        final ingredient = ingredients[index];
                        return Dismissible(key: Key(ingredient["name"]),
                            onDismissed: (direction)
                      {
                      DeleteIngredient(ingredient["name"]);


                      },
                            background: Container(color: Colors.grey),
                            child: ShoppingListItemWidget(ingredient)
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


