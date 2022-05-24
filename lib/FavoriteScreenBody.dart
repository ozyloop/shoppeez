import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppeez/favoriteChangeNotifier.dart';
import 'package:shoppeez/ingredientDatabase.dart';
import 'package:shoppeez/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'RecipeItemWidget.dart';
import 'ShoppingListItemWidget.dart';
import 'favoriteWidget.dart';
import 'package:http/http.dart' as http;

class FavoriteScreenBody extends StatefulWidget
{

  @override
  State<StatefulWidget> createState()
  {
    return FavoriteScreenBodyState();
  }

}

class FavoriteScreenBodyState extends State<FavoriteScreenBody>
{

  final TextEditingController _controller = TextEditingController();
  @override
  Future GetMethod() async
  {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id') ;
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/FavoriteList.php?id=" + id.toString());
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);
    print("${responsBody[0]}");
    print("space");
    return responsBody;
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(
        title: Text("Shoppeez"),
      ),
      body: FutureBuilder(
          future: GetMethod(),
          builder: (context, AsyncSnapshot snapshot)
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
                  child: Column(
                      children:
                      [
                        Expanded(
                          child : ListView.builder(
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
                                        SnackBar(content: Text("${recipe.name} supprimé"))
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
      )

    );

  }
  }