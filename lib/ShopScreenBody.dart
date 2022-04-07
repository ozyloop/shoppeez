import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppeez/recipeDatabase.dart';

import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';


class ShopScreenBody extends StatelessWidget
{

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder<List<Ingredient>>(
future: IngredientDataBase.instance.ingredients(),
builder: (BuildContext context, AsyncSnapshot<List<Ingredient>> snapshot)
{
if (snapshot.hasData)
{
List<Ingredient>? ingredients = snapshot.data;
return
Stack(
children:
[
ListView(children:[Container(child:
Expanded(child:
Row(mainAxisAlignment: MainAxisAlignment.center,
children: [
TextButton(
child: Text('Meat'),
style: TextButton.styleFrom(primary: Colors.pinkAccent),
onPressed: () {
print('Pressed');
}),
TextButton(
child: Text('Fish'),
style: TextButton.styleFrom(primary: Colors.pinkAccent),
onPressed: () {
print('Pressed');
}),
TextButton(
child: Text('Drink'),
style: TextButton.styleFrom(primary: Colors.pinkAccent),
onPressed: () {
print('Pressed');
}),
TextButton(
child: Text('Diary'),
style: TextButton.styleFrom(primary: Colors.pinkAccent),
onPressed: () {
print('Pressed');
}),
TextButton(
child: Text('Vegetables'),
style: TextButton.styleFrom(primary: Colors.pinkAccent),
onPressed: () {
print('Pressed');
}),



])),),


//use after when clic on the research button
/*TextField(
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
                      )*/

Padding(
padding: EdgeInsets.symmetric(horizontal: 8),
child:Row(
mainAxisAlignment: MainAxisAlignment.end,
children:
[
Text("Sort by :  "),
Text("A-Z"),
IconButton(
icon: Icon(Icons.arrow_drop_down),
onPressed: () =>  _controller.text ="",
),
],
)
),

Container(
width: MediaQuery.of(context).size.width,
height: 600,
child:
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
),
),
]
),
Positioned(
bottom:10,
right: 10,

child: ElevatedButton(
style: TextButton.styleFrom(primary: Colors.black, backgroundColor: Colors.orange, fixedSize: Size(60,55), minimumSize: Size(50,40)),


onPressed: () {

SearchBar(context, _controller).then((result) {
print('In Builder');
});
},
child: const Icon(Icons.search, size:30 ),

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
) ;  }

  void setState(Null Function() param0) {}
}


