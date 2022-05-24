import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favoriteChangeNotifier.dart';
import 'package:http/http.dart' as http;

class FavoriteIconWidget extends StatefulWidget {
  FavoriteIconWidget(this.recipe);
  late dynamic recipe;

  _FavoriteIconWidgetState createState() => _FavoriteIconWidgetState(recipe);
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  _FavoriteIconWidgetState(this.recipe) ;
  late dynamic recipe;

  late bool _isFavorited = Favorite();
  late String recipe_id = recipe["recipe_id"];
  @override
  Future GetResearch() async
  {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id');
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/GetOneRecipe.php?id="+recipe_id);
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);

    return responsBody;
  }

   @override
   bool Favorite()
   {
     bool favorited;
     if(recipe["fk_customer_id"]==null)
       {
         print(recipe["fk_customer_id"]);
         favorited = false;
       }
     else
     {
       print('test2');
       favorited = true;
     }

     return favorited;
   }

  @override
  void DeleteFavorite() async
  {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id');
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/DeleteFavorite.php?recipe_id="+recipe["recipe_id"]+"&customer_id="+id.toString());
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    setState(() {
      recipe["fk_customer_id"] = null;
    });

  }
  @override
  void CreateFavorite() async
  {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id');
    print(recipe["fk_customer_id"]);
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/CreateFavorite.php?recipe_id="+recipe["recipe_id"]+"&customer_id="+id.toString());
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    setState(() {
      recipe["fk_customer_id"] = id;
    });


  }

  @override
   void _toggleFavorite(){
    setState(() {
      if(recipe["fk_customer_id"]==null)
      {
        print(true);
        CreateFavorite();
        _isFavorited = true;
      }
      else
      {
        print(false);
        DeleteFavorite();
        _isFavorited = false;
      }});
  }
  @override
  Widget build(BuildContext context) {

    return
        IconButton(
          icon: _isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          color:Colors.red,
          onPressed: ()=> _toggleFavorite(),
        );

  }


}

class FavoriteTextWidget extends StatefulWidget {
  _FavoriteTextWidgetState createState() => _FavoriteTextWidgetState();
}

class _FavoriteTextWidgetState extends State<FavoriteTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(context,notifier, _) => Text('favorite'));//notifier.favoriteCount.toString()));
  }
}