import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppeez/recipe.dart';

class RecipeItemWidget extends StatelessWidget
{
  RecipeItemWidget(this.recipe) ;
  final dynamic recipe;
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
                              padding: EdgeInsets.all(8),
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
                      onPressed: () => print("works")
                  ),
                )
              ]
          ),
        )

    );
  }
}