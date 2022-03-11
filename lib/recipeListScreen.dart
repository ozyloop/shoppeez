import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppeez/ingredient.dart';
import 'package:shoppeez/quantityWidget.dart';
import 'package:shoppeez/recipeDatabase.dart';
import 'package:shoppeez/recipeScreen.dart';
import 'package:shoppeez/recipe.dart';

import 'ingredientDatabase.dart';

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
      FutureBuilder<List<Recipe>>(
        future: RecipeDataBase.instance.recipes(),
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot)
          {
            if (snapshot.hasData)
            {
              List<Recipe>? recipes = snapshot.data;
              return Column(children:
                [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child:TextField(
                      controller: _controller, onSubmitted: (String value) async
                      {
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context)
                          {
                            return AlertDialog(
                              title: const Text('Thanks!'),
                              content: Text('You typed "$value", which has length ${value.characters.length}.'),
                              actions: <Widget>
                              [
                              ],
                            );
                          },
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'ingredients',
                        labelText: 'What do you have to cook ? ',
                        prefixIcon: Icon(Icons.food_bank, color: Colors.red),
                        // icon: Icon(Icons.food),
                        suffixIcon: _controller.text.isEmpty
                        ? Container(width: 0):
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () =>  _controller.text ="",
                        ),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    )
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: recipes!.length,
                      itemBuilder: (context, index)
                      {
                      final recipe = recipes[index];
                      return Dismissible(key: Key(recipe.title),
                        onDismissed: (direction)
                        {
                          setState(()
                            {
                            RecipeDataBase.instance.deleteRecipe(recipe.title);
                            }
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${recipe.title} supprimé"))
                          );
                        },
                        background: Container(color: Colors.grey),
                        child: RecipeItemWidget(recipe: recipe)
                      );
                    },
                  ),
                )
              ]
            );
          }
          else
          {
            return Center(child: Text("No Data"));
          }
        }
      ):
         //children
              //shopping screen body
          //test if index = 0 shopping list page
      _selectedIndex==0 ?
      FutureBuilder<List<Ingredient>>(
        future: IngredientDataBase.instance.ingredients(),
        builder: (BuildContext context, AsyncSnapshot<List<Ingredient>> snapshot)
        {
          if (snapshot.hasData)
          {
            List<Ingredient>? ingredients = snapshot.data;
            return Column(
              children:
              [
                Expanded(
                  child : ListView.builder(
                   itemCount: ingredients!.length,
                   itemBuilder: (context, index)
                   {
                     final ingredient = ingredients[index];
                     return Dismissible(key: Key(ingredient.name),
                       onDismissed: (direction)
                       {
                         setState(()
                           {
                             IngredientDataBase.instance.deleteIngredient(ingredient.name);
                           }
                         );
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text("${ingredient.name} supprimé"))
                         );
                       },
                       background: Container(color: Colors.grey),
                       child: ShoppingListItemWidget(ingredient: ingredient)
                     );
                   },
                  ),
                )
              ]
            );
          }
          else
          {
            return Center(child: Text("No Data"));
          }
        }
      ):

        //shop screen body
      FutureBuilder<List<Ingredient>>(
        future: IngredientDataBase.instance.ingredients(),
        builder: (BuildContext context, AsyncSnapshot<List<Ingredient>> snapshot)
        {
          if (snapshot.hasData)
          {
            List<Ingredient>? ingredients = snapshot.data;
            return Column(children:
              [
                Container(
                  padding: const EdgeInsets.all(8),
                  child:TextField(
                    controller: _controller,
                    onSubmitted: (String value) async
                    {
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context)
                        {
                          return AlertDialog(
                            title: const Text('Thanks!'),
                            content: Text('You typed "$value", which has length ${value.characters.length}.'),
                            actions: <Widget>[
                            ],
                          );
                        },
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'ingredients',
                      labelText: 'What do you have to cook ? ',
                      prefixIcon: Icon(Icons.food_bank, color: Colors.red),
                      // icon: Icon(Icons.food),
                      suffixIcon: _controller.text.isEmpty
                      ? Container(width: 0) :
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () =>  _controller.text ="",
                      ),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  )
                ),
                Container(
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ingredients!.length,
                    itemBuilder: (context, index)
                    {
                      final ingredient = ingredients[index];
                      return Dismissible(key: Key(ingredient.name),
                        onDismissed: (direction)
                        {
                          setState(()
                            {
                              IngredientDataBase.instance.deleteIngredient(ingredient.name);
                            }
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${ingredient.name} supprimé"))
                          );
                        },
                        background: Container(color: Colors.grey),
                        child: ShopItemWidget(ingredient: ingredient)
                      );
                    },
                  ),
                )
              ]
            );
          }
          else
          {
            return Center(child: Text("No Data"));
          }
        }
      ),
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
// need to indent the next part//

//widget for the recipe part
class RecipeItemWidget extends StatelessWidget
{
  const RecipeItemWidget({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;
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
                    tag: "imageRecipe" + recipe.title,
                    child:CachedNetworkImage(
                      imageUrl: recipe.imageUrl,
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
                            recipe.title,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                          ),
                        ),
                        Text(
                          recipe.user,
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

//widget for the shopping list part
class ShoppingListItemWidget extends StatelessWidget
{
  const ShoppingListItemWidget({Key? key, required this.ingredient}) : super(key: key);
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
                                fontSize: 20,
                              )
                            ),
                          ),
                          Text(
                            ingredient.type,
                            style: TextStyle(
                              color: Colors.grey[500], fontSize: 16)
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
            children:
            [
              Text(ingredient.quantity.toString()),
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
//widget for the shop list part
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


