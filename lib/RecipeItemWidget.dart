import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppeez/recipe.dart';
import 'package:http/http.dart' as http;
class RecipeItemWidget extends StatelessWidget
{
  RecipeItemWidget(this.recipe) ;
  final dynamic recipe;

  @override
  void AddRecipeIngredient() async
  {
    print("Add method");
    final prefs = await SharedPreferences.getInstance();
    final customer_id = prefs.getInt('customer_id') ;
    //get igredient of the recipe
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/GetRecipeIngredients.php?recipe_id="+recipe["recipe_id"]);
    print("https://shoppeaz.000webhostapp.com/AddRecipeIngredients.php?customer_id="+customer_id.toString()+"&recipe_id=5"+recipe["recipe_id"]);
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);


    var theUrlShopping = Uri.parse("https://shoppeaz.000webhostapp.com/ShoppingListItems.php?id=" + customer_id.toString());
    var resShopping = await http.get(theUrlShopping, headers: {"Accept":"application/json"});
    var shoppingList = json.decode(resShopping.body);
    print("before calculus");
    CalculusRecipeIngredient(responsBody, shoppingList);
  }

  @override
  void CalculusRecipeIngredient(dynamic recipeIngredients, dynamic shoppingList) async
  {
    print("into calculus");
    final prefs = await SharedPreferences.getInstance();
    final customer_id = prefs.getInt('customer_id') ;
    //loop and test for each ingredient if it exists in shopping list
    for (var j = 0; j < recipeIngredients.length; j++) {
      bool found = false;
      for (var i = 0; i < shoppingList.length; i++) {
        if (recipeIngredients[j]['fk_ingredient_name'] == shoppingList[i]['fk_ingredient_name']) {
          found=true;
          //if it exists, add the quantity according to the include quantity
          var quantity;
          if(recipeIngredients[j]['quantity_type'] == "tablespoons")
            {
              if(shoppingList[i]['quantity_type'] == "g" || shoppingList[i]['quantity_type'] == "mL"){
                quantity = 15 + shoppingList[i]['quantity'];
              }
              else if (shoppingList[i]['quantity_type'] == "kg" || shoppingList[i]['quantity_type'] == "L")
                {
                  quantity = 0.015 + shoppingList[i]['quantity'];
                }
            }
          else if(recipeIngredients[j]['quantity_type'] == "teaspoons")
          {
            if(shoppingList[i]['quantity_type'] == "g" || shoppingList[i]['quantity_type'] == "mL"){
              quantity = 5 + shoppingList[i]['quantity'];
            }
            else if (shoppingList[i]['quantity_type'] == "kg" || shoppingList[i]['quantity_type'] == "L")
            {
              quantity = 0.005 + shoppingList[i]['quantity'];
            }
          }
          else if(recipeIngredients[j]['quantity_type'] == "cup")
          {
            if(shoppingList[i]['quantity_type'] == "g" || shoppingList[i]['quantity_type'] == "mL"){
              quantity = 240 + shoppingList[i]['quantity'];
            }
            else if (shoppingList[i]['quantity_type'] == "kg" || shoppingList[i]['quantity_type'] == "L")
            {
              quantity = 0.240 + shoppingList[i]['quantity'];
            }
          }
          else{
            print("calcul of quantity");
            quantity = double.parse(recipeIngredients[j]['quantity']) + double.parse(shoppingList[j]['quantity']);
          }

          var theUrl2 = Uri.parse("https://shoppeaz.000webhostapp.com/SetQuantityShoppingList.php?quantity=" + quantity.toString() + "&name=" + shoppingList[j]['fk_ingredient_name'] + "&customer_id="+ customer_id.toString() );
          await http.get(theUrl2, headers: {"Accept": "application/json"});
        }

      }
      if(found == false)
      {

        var theUrlRef = Uri.parse("https://shoppeaz.000webhostapp.com/GetSpecialIngredient.php?name="+recipeIngredients[j]["fk_ingredient_name"]);
        var resRef = await http.get(theUrlRef, headers: {"Accept":"application/json"});
        var ingredientRef = json.decode(resRef.body);

        var quantity;
        if(ingredientRef[0]['quantity_type_reference'] == "tablespoon")
        {
          if(shoppingList[0]['quantity_type_reference'] == "g" || shoppingList[0]['quantity_type_reference'] == "mL"){
            quantity = 15 ;
          }
          else if (shoppingList[0]['quantity_type_reference'] == "kg" || shoppingList[0]['quantity_type_reference'] == "L")
          {
            quantity = 0.015 ;
          }
        }
        else if(recipeIngredients[j]['quantity_type_reference'] == "teaspoon")
        {
          if(shoppingList[0]['quantity_type_reference'] == "g" || shoppingList[0]['quantity_type_reference'] == "mL"){
            quantity = 5 ;
          }
          else if (shoppingList[0]['quantity_type_reference'] == "kg" || shoppingList[0]['quantity_type_reference'] == "L")
          {
            quantity = 0.005 ;
          }
        }
        else if(recipeIngredients[j]['quantity_type_reference'] == "cup")
        {
          if(shoppingList[0]['quantity_type_reference'] == "g" || shoppingList[0]['quantity_type_reference'] == "mL"){
            quantity = 240 ;
          }
          else if (shoppingList[0]['quantity_type_reference'] == "kg" || shoppingList[0]['quantity_type_reference'] == "L")
          {
            quantity = 0.240 ;
          }
        }

        //
        var theUrl2 = Uri.parse("https://shoppeaz.000webhostapp.com/AddIngredientShoppingList.php?name=" + recipeIngredients[j]["fk_ingredient_name"] +"&customer_id="+ customer_id.toString()+"&quantity="+recipeIngredients[j]["quantity"].toString());
        var res2 = await http.get(theUrl2, headers: {"Accept":"application/json"});
        
      }
    }

    //else add the ingredients and its quantity in the shopping list with the ingredients quantity_type_reference
  }



  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
        onTap: ()
        {
          Navigator.pushNamed(
            context,
            '/recipe',
            arguments: recipe,
          );
        },


        child: Card(
          color: Color(0xFFFFFFFF),
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
                              tag: "imageRecipe" + recipe["name"],
                              child:CachedNetworkImage(
                                imageUrl: recipe["photo"],
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child : Text(
                                        recipe["name"],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                                    ),
                                  ),
                                  Text(
                                      "Pas de User",
                                      style: TextStyle(color: Colors.grey[500], fontSize: 16)
                                  )
                                ],
                              )
                          )
                        ]
                    )
                ),
                Container(
                  padding: const EdgeInsets.only(right: 8),
                  child:IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.red,
                      onPressed: () => AddRecipeIngredient()
                  ),
                )
              ]
          ),
        )

    );
  }
}