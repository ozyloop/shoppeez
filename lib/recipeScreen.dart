import 'package:flutter/material.dart';
import 'package:shoppeez/favoriteChangeNotifier.dart';
import 'package:shoppeez/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'favoriteWidget.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
        padding: const EdgeInsets.all(8),
        child : Row(
          children: [
            Expanded(
              child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom:8),
                      child:Text(recipe.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20
                        ),
                      ),
                    ),
                    Text(recipe.user,
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: 20
                      ),)
                  ]
              ),),
            FavoriteIconWidget(),
            FavoriteTextWidget(),
          ],
        ));

    Widget buttonSection = Container(
      padding: const EdgeInsets.all(8),
      child:
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(Colors.blue, Icons.people, "2"),
            _buildButtonColumn(Colors.blue, Icons.food_bank, "Ingredients"),
            _buildButtonColumn(Colors.blue, Icons.add_shopping_cart, "Add List")
          ] ),);

    Widget descriptionSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text( recipe.description,
        softWrap: true,
      ),
    );


    return ChangeNotifierProvider(
      create: (context)=> FavoriteChangeNotifier(recipe),
        child: Scaffold(
        appBar: AppBar(
        title: Text("Shoppeez"),
      ),
      body: ListView(
                children:[
                  Hero(
                      tag: "imageRecipe" + recipe.title,
              child : CachedNetworkImage(
                imageUrl: recipe.imageUrl,
                placeholder: (context,url) => Center(child:CircularProgressIndicator()),
                errorWidget: (context, url, error)=> Icon(Icons.error),
                width: 600,
                height: 240,
                fit:BoxFit.cover,
              )),


            titleSection,
            buttonSection,
            descriptionSection,
                ]
      ),

    )
    );
  }
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child:
            Icon(icon, color: color),
          ),
          Text(label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: color,
              ))
        ]
    );
  }
}