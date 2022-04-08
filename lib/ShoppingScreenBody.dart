import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/getData.php");
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);
    print("${responsBody[0]}");
    print("space");
    return responsBody;
  }


  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
        future: GetMethod(),
        builder: (BuildContext context, AsyncSnapshot snapshot)
        {
          if (snapshot.hasData)
          {
            List<dynamic> ingredients = snapshot.data;
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
                      itemCount: ingredients.length,
                      itemBuilder: (context, index)
                      {
                        final ingredient = ingredients[index];
                        return Dismissible(key: Key(ingredient["name"]),
                            onDismissed: (direction)
                            {
                              setState(()
                              {

                              }
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${ingredient.name} supprimé"))
                              );
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
                    child: Text("No Data")));
          }
        }
    ) ;  }

  void setState(Null Function() param0) {}
}


