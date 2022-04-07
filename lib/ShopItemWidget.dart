import 'package:flutter/material.dart';

import 'ingredient.dart';

class ShopItemWidget extends StatelessWidget
{
  const ShopItemWidget({Key? key, required this.ingredient}) : super(key: key);
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context)
  {
    return Card(
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
                          tag: "imageIngredient" + ingredient.name,
                          child: Image.asset(
                            ingredient.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
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
                                          ingredient.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                    Text(
                                        ingredient.type,
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
                      onPressed: () => print("works")
                  ),
                  Text("3"),
                  IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.red,
                      onPressed: () => print("works")
                  ),
                ]
            )
          ]
      ),
    );
  }
}