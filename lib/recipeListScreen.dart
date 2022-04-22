import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppeez/ShopScreenBody.dart';
import 'package:shoppeez/ShoppingScreenBody.dart';
import 'package:shoppeez/ingredient.dart';
import 'package:shoppeez/quantityWidget.dart';
import 'package:shoppeez/recipeDatabase.dart';
import 'package:shoppeez/recipeScreen.dart';
import 'package:shoppeez/recipe.dart';

import 'LoginPageBody.dart';
import 'ProfilePage.dart';
import 'RecipeItemWidget.dart';
import 'RecipeScreenBody.dart';
import 'RecipeScreenIngredient.dart';
import 'RegisterPageBody.dart';
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

  late int id ;
  @override
  void getId() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getInt('customer_id')!;
  }
  @override
  void Refresh() async {
    var prefs = await SharedPreferences.getInstance();
    var customer_id = prefs.getInt('customer_id') ;
    print('yo');
  setState(() {
    id = customer_id!;
  });



  }





  @override
  void _onItemTapped(int index)
  {
    setState(()
    {
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
    getId();
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
      _selectedIndex==2 ?
      //shop screen body
      ShopScreenBody():
      id == 0 ?
      LoginPageBody(Refresh):

      ProfilePageBody(Refresh),


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>
        [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            backgroundColor: Color(0xFF1860BA),
            label: 'Shopping List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_home_screen),
            backgroundColor: Color(0xFF1860BA),
            label: 'Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            backgroundColor: Color(0xFF1860BA),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            backgroundColor: Color(0xFF1860BA),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF2FE3CB),
        onTap: _onItemTapped,
      ),
    );
  }
}



