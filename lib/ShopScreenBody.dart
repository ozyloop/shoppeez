import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppeez/BddController.dart';
import 'package:shoppeez/recipeDatabase.dart';
import 'package:shoppeez/recipeListScreen.dart';

import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';





class ShopScreenBody extends StatefulWidget
{

  @override
  State<StatefulWidget> createState()
  {
    return ShopScreenBodyState();
  }

}

class ShopScreenBodyState extends State<ShopScreenBody>
{

  final TextEditingController _controller = TextEditingController();
  late bool sortBy=true;
  final List<String> SortByList = ['Sort By: A-Z', 'Sort By: Z-A'];
  late String SortText = 'Sort By: A-Z';
  String dropdownvalue = 'All';
  late List<dynamic> IngredientList;
  late List<dynamic> IngredientListStatic;
  late ListView Cards;
  late String search = "";
  List<String> options = <String>[
    'All',
    'Meat',
    'SeaFood',
    'Vegetable',
    'Fruit',
    'Spices',
    'Dairy',
    'Drinks',
    'Sweets',
    'Starch',
    'Other',
    'Oil',
    'Pules',
    'Cereal',
    'Flavor',
    'Sauce'
  ];


  @override
  Future  GetSpecialData() async
  {

    if(dropdownvalue == "All")
      {
        var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/ResearchIngredient.php?search="+search);
        var res = await http.get(theUrl, headers: {"Accept":"application/json"});
        var responsBody = json.decode(res.body);

        setState(() {
          IngredientList = responsBody;
        });
        IngredientList = SortAZ(sortBy, IngredientList);
        print('     ');
        return IngredientList;

      }
    else
      {
        var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/Filter.php?category=" + dropdownvalue+"&search="+search);
        var res = await http.get(theUrl, headers: {"Accept":"application/json"});
        var responsBody = json.decode(res.body);

        setState(() {
          IngredientList = responsBody;
        });
        IngredientList = SortAZ(sortBy, IngredientList);
        return IngredientList;
      }


  }


  @override
  List<dynamic> SortAZ(bool direction, List<dynamic> ingredients)
  {
    if(direction){
      ingredients.sort((a, b) => a.toString().compareTo(b.toString()));
      setState(() {
        IngredientList = ingredients;
      });

      return IngredientList;
    }
    else {
      ingredients.sort((b,a) => a.toString().compareTo(b.toString()));
      setState(() {
        IngredientList = ingredients;
      });

      return IngredientList;
    }
  }



  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      future: GetSpecialData(),
      builder: (BuildContext context, AsyncSnapshot snapshot)
      {
          if (snapshot.hasData)
        {

          IngredientList = snapshot.data;


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
                  [Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1860BA),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(8),
                      child:TextField(

                    controller: _controller, onSubmitted: (String value) async
                  {
                    setState(() {
                      search = value;
                    });
                    GetSpecialData();
                    print('executed');

                  },
                    decoration: InputDecoration(

                      hintText: 'What do you want to cook ? ',

                      hintStyle: TextStyle(
                        color: Color(0xFF2FE3CB),
                        fontFamily: 'OpenSans',
                      ),

                      prefixIcon: Icon(Icons.food_bank, color: Color(0xFF2FE3CB)),
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
                  )),
                    Container(

                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[ Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child:  DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    Icon(
                                      Icons.list,
                                      size: 16,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select Item',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: options
                                    .map((item) =>
                                    DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                    .toList(),
                                value: dropdownvalue,
                                onChanged: (value) {

                                  setState(() {
                                    dropdownvalue = value as String;

                                  });


                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                ),
                                iconSize: 20,
                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.grey,
                                buttonHeight: 50,
                                buttonWidth: 160,
                                buttonPadding: const EdgeInsets.only(left: 14, right: 20),


                                itemHeight: 40,
                                itemPadding: const EdgeInsets.only(left: 14, right: 14),


                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Color(0xFF398AE5),
                                ),
                                dropdownElevation: 8,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-5, 0),
                              ),
                          ),








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
                          SortText,
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 16),
                        ),
                        onPressed: () {

                          if(sortBy){ setState(() {

                            sortBy = false;
                            SortText=SortByList[1];

                          });}

                          else {setState(() {
                            sortBy = true;
                            SortText=SortByList[0];
                          });}
                          print(sortBy);

                        },
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
                       Cards = ListView.builder(
                          itemCount: IngredientList.length,
                          itemBuilder: (context, index)
                          {
                            dynamic ingredient = IngredientList[index];
                            return Dismissible(
                                key: Key(ingredient["name"]),
                                onDismissed: (direction)
                                {
                                  setState(()
                                  {

                                  }
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("supprimé"))
                                  );
                                },
                                background: Container(color: Colors.grey),
                                child: ShopItemWidget(ingredient)
                            );
                          },
                        ),

                    ),
                  ]
              ),
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
                  child: Text("Loading")));
        }
      }
    );
  }




}


