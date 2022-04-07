import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppeez/ShopScreenBody.dart';
import 'package:shoppeez/ShoppingScreenBody.dart';
import 'package:shoppeez/ingredient.dart';
import 'package:shoppeez/quantityWidget.dart';
import 'package:shoppeez/recipeDatabase.dart';
import 'package:shoppeez/recipeScreen.dart';
import 'package:shoppeez/recipe.dart';

import 'RecipeItemWidget.dart';
import 'RecipeScreenBody.dart';
import 'RecipeScreenIngredient.dart';
import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ingredientDatabase.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeListScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return RecipeListScreenState();
  }
}


class RecipeListScreenState extends State<RecipeListScreen>
{
  int _selectedIndex=1;
  late TextEditingController _controller;

  @override
  void _onItemTapped(int index)
  {
    setState(()
    {
      print(_selectedIndex);
      _selectedIndex = index;
    }
    );
  }
  @override
  void initState()
  {
    super.initState();
    _controller = TextEditingController();
  }
  //method to have access to the database
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
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoppeez"),
      ),
      //recipes screen body
      // Test if index = 1 recipe page
      body: _selectedIndex==1?
      RecipeScreenBody():
         //children

          //test if index = 0 shopping list page // shopping screen body
      _selectedIndex==0 ?
      ShoppingScreenBody():
      //shop screen body
      ShopScreenBody(),


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>
        [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Shopping List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_home_screen),
            label: 'Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}



