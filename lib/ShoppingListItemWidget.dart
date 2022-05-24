import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ingredient.dart';

class ShoppingListItemWidget extends StatelessWidget
{
  ShoppingListItemWidget(this.ingredient ) ;
  final dynamic ingredient;


  @override
  Widget build(BuildContext context)
  {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                     Row(children: [Hero(
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
                           padding: const EdgeInsets.only(left: 8),
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
                                             fontSize: 20,
                                           )
                                       ),
                                     ),
                                     Text(
                                         ingredient["category"],
                                         style: TextStyle(
                                             color: Colors.grey[500], fontSize: 16)
                                     )
                                   ],
                                 ),





                               ]
                           )
                       ),],) ,
                  Padding(
                  padding: const EdgeInsets.only(right: 8),

                  child:  Row(
                            children:
                            [
                              Text(ingredient["quantity"]),
                              Text(ingredient["quantity_type"]),

                            ]
                        ))
                    ]
                )



    );
  }
}