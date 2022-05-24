import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ingredient.dart';
import 'package:http/http.dart' as http;

class ShopItemWidget extends StatefulWidget
{
  ShopItemWidget(this.ingredient ) ;
  final dynamic ingredient;

  @override
  State<StatefulWidget> createState()
  {
    return ShopItemWidgetState(ingredient);
  }

}

class ShopItemWidgetState extends State<ShopItemWidget>
{
  ShopItemWidgetState(this.ingredient ) ;
  final dynamic ingredient;

  late double quantity = double.parse(ingredient["quantity_reference"]);
  @override
  void SetShoppingListQuantity() async
  {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id') ;
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/ShoppingListItems.php?id=" + id.toString());
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);

     Calculus(responsBody);


  }

  @override
  void Calculus(dynamic shoppingList) async
  {

    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id') ;
    bool found = false;
    for (var j = 0; j < shoppingList.length; j++) {
      if(ingredient['name']==shoppingList[j]['name'])
        {

          var quantity_shopping_list = quantity + double.parse(shoppingList[j]['quantity']);
          var theUrl2 = Uri.parse("https://shoppeaz.000webhostapp.com/SetQuantityShoppingList.php?quantity=" + quantity_shopping_list.toString()+"&name="+shoppingList[j]['name']);
          var res2 = await http.get(theUrl2, headers: {"Accept":"application/json"});
          var responsBody2 = json.decode(res2.body);
          found = true;
        }
    }
    if(found == false)
      {

        var theUrl2 = Uri.parse("https://shoppeaz.000webhostapp.com/AddIngredientShoppingList.php?name=" + ingredient["name"] +"&customer_id="+ id.toString()+"&quantity="+quantity.toString());
        var res2 = await http.get(theUrl2, headers: {"Accept":"application/json"});
        var responsBody2 = json.decode(res2.body);
      }
  }

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
        onTap: ()
    {

      SetShoppingListQuantity();
    },

      child : Card(
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
                          tag: "imageIngredient" + ingredient["name"],
                          child: CachedNetworkImage(
                            imageUrl: ingredient["photo"],
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,)
                      ),
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                              children:
                              [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                  [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                          ingredient["name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                    Text(
                                        ingredient['category'],
                                        style: TextStyle(color: Colors.grey[500], fontSize: 16)
                                    )
                                  ],
                                ),
                              ]
                          )
                      )
                    ]
                )
            ),
            Row(
              //padding: const EdgeInsets.only(right: 8),
                children:
                [
                  IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                      onPressed: () {
      quantity = quantity - double.parse(ingredient["quantity_reference"]);
      print(quantity);

    }
                  ),
                  Text(quantity.toString()),
                  Text(ingredient["quantity_type_reference"]),
                  IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.red,
                      onPressed: () {
                        quantity = quantity + double.parse(ingredient["quantity_reference"]);
                        print(quantity);

                      }
                    ),
                ]
            )
          ]
      ),
    ));
  }
}