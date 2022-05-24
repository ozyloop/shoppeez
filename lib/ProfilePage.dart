

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppeez/recipeDatabase.dart';
import 'package:shoppeez/recipeListScreen.dart';

import 'CustomerLocalSave.dart';
import 'RecipeScreenIngredient.dart';
import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ShoppingListItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProfilePageBody extends StatefulWidget
{
  late Function Refresh;

  ProfilePageBody(this.Refresh);
  @override
  State<StatefulWidget> createState()
  {
    return ProfilePageBodyState();
  }

}

class ProfilePageBodyState extends State<ProfilePageBody>
{


  final TextEditingController _controller = TextEditingController();

  final _Email = TextEditingController();
  final _Password = TextEditingController();

  String Email="";
  String Password="";



  @override
  Future GetMethod() async
  {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('customer_id') ;
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/ProfilePage.php?id=" + id.toString());
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);
    return responsBody;
  }

  Widget NameRow(String customer_String) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF6CA8F1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 120.0,
        child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(padding: const EdgeInsets.all(16),
                child:Text(
                    'First Name :',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ))),
              Container(padding: const EdgeInsets.all(16),
                  child:Text(
                      customer_String,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ))),
            ]
        )
    );



  }
  Widget LastNameRow(String customer_String) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF6CA8F1),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        height: 120.0,
        child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(padding: const EdgeInsets.all(16),
                child:Text(
                    'Last Name :',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ))),
              Container(padding: const EdgeInsets.all(16),
                  child:Text(
                      customer_String,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ))),
            ]
        )
    );




  }
  Widget EmailRow(String customer_String) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFF6CA8F1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 120.0,
      child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(16),

                child:Text(
                    'Email :',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ))),
            Container(padding: const EdgeInsets.all(16),
                child:Text(
                    customer_String,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ))),
          ]
      )
    );


  }


  Widget ProfilePic(String PicsUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [CachedNetworkImage(
      imageUrl: PicsUrl,
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
      width: 80,
      height: 100,
      fit: BoxFit.cover,)]);
  }

  Widget _buildFavoriteBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.pushNamed(
            context,
            '/Favorite'),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Favorites',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  Widget _buildLogOutBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          IdRepository().save(int.parse('0'));
          this.widget.Refresh();},

        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Log Out',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetMethod(),
    builder: (context, AsyncSnapshot snapshot)
    {
    if (snapshot.hasData) {
      List<dynamic> customer = snapshot.data;
      return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
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
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 50.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ProfilePic("https://i.postimg.cc/k6nHL0v2/023.png"),
                        SizedBox(height: 20.0, ),
                        NameRow(customer[0]['first_name']),
                        SizedBox(height: 20.0, ),
                        LastNameRow(customer[0]['last_name']),
                        SizedBox(height: 20.0, ),
                        EmailRow(customer[0]['email']),
                        _buildFavoriteBtn(context),
                        _buildLogOutBtn(),
                        SizedBox(height: 30.0,),

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
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
    });


  }


}

