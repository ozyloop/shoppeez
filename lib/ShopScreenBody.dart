import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppeez/recipeDatabase.dart';

import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class ShopScreenBody extends StatelessWidget
{

  final TextEditingController _controller = TextEditingController();
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
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      future: GetMethod(),
      builder: (BuildContext context, AsyncSnapshot snapshot)
      {
          if (snapshot.hasData)
        {
          List<dynamic>? ingredients = snapshot.data;
          return Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
              Color(0xFF73AEF5),
        Color(0xFF61A4F1),
        Color(0xFF478DE0),
        Color(0xFF398AE5),
        ],
        stops: [0.1, 0.4, 0.7, 0.9],
        ),
        ), child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.loose,
              children:
            [

                  ListView(
                  children:
                  [
                    Container(

                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[ Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child:TextButton.icon(
                                icon: RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(Icons.compare_arrows,
                                      color: Color(0xFFFFFFFF),
                                      size: 28),
                                ),
                                label: Text(
                                  'Sort By: All',
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16),
                                ),
                                onPressed: () {},
                              )
          ),






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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child:TextButton.icon(
                        icon: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.compare_arrows,
                              color: Color(0xFFFFFFFF),
                              size: 28),
                        ),
                        label: Text(
                          'Sort By: A-Z',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16),
                        ),
                        onPressed: () {},
                      )


                      /*Row(
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
                      )*/
                    ),])),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      child:
                      Expanded(
                        child: ListView.builder(
                          itemCount: ingredients!.length,
                          itemBuilder: (context, index)
                          {
                            final ingredient = ingredients[index];
                            return Dismissible(
                                key: Key(ingredient["name"]),
                                onDismissed: (direction)
                                {
                                  setState(()
                                  {

                                  }
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${ingredient["name"]} supprimé"))
                                  );
                                },
                                background: Container(color: Colors.grey),
                                child: ShopItemWidget(ingredient)
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
                  child:
                  Container(
                    height: 40,
                    width: 40,
                    child: DecoratedBox(
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.search, color: Theme.of(context).primaryColor, size: 35,), onPressed: () {
                        Navigator.of(context).pop();
                      }),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                  )
              ),

               /*Positioned(
                bottom:10,
                right: 10,

                child: ElevatedButton(
                  style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Colors.blue, fixedSize: Size(60,55), minimumSize: Size(50,40)),
                  onPressed: ()
                  {
                    SearchBar(context, _controller).then((result)
                      {
                        print('In Builder');
                      }
                    );
                  },
                  child: const Icon(Icons.search, size:30 ),

                ),
              )*/
            ]
          ));
        }
        else
        {
          return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
              child:Center(
                  child: Text("No Data")));
        }
      }
    );
  }
  void setState(Null Function() param0) {}
}


