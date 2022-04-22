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
    final prefs = await SharedPreferences.getInstance();
    final customer_id = prefs.getInt('customer_id') ;
    print(customer_id.toString());
    print(recipe["recipe_id"]);
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/AddRecipeIngredients.php?customer_id="+customer_id.toString()+"&recipe_id="+recipe["recipe_id"]);
    print("https://shoppeaz.000webhostapp.com/AddRecipeIngredients.php?customer_id="+customer_id.toString()+"&recipe_id=5"+recipe["recipe_id"]);
    await http.get(theUrl, headers: {"Accept":"application/json"});

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