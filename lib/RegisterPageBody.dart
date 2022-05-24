import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppeez/recipeDatabase.dart';

import 'RecipeScreenIngredient.dart';
import 'SearchBarWidget.dart';
import 'ShopItemWidget.dart';
import 'ShoppingListItemWidget.dart';
import 'ingredient.dart';
import 'ingredientDatabase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CustomerLocalSave.dart';


class RegisterPageBody extends StatelessWidget
{

  final TextEditingController _controller = TextEditingController();
  final _First_Name = TextEditingController();
  final _Last_Name = TextEditingController();
  final _Email = TextEditingController();
  final _Password = TextEditingController();

  String First_name="";
  String Last_name="";
  String Email="";
  String Password="";
  String Photo="";





  @override
  void Register() async
  {

  var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/Register.php?first_name=" + First_name +"&last_name=" + Last_name + "&email=" + Email + "&password=" + Password+ "&profile_pic="+Photo);
  await http.get(theUrl, headers: {"Accept":"application/json"});
  var theUrl2 = Uri.parse("https://shoppeaz.000webhostapp.com/Login.php?email="+Email +"&password=" +Password);
  var res = await http.get(theUrl2, headers: {"Accept":"application/json"});
  var Customer_ID = json.decode(res.body);
  IdRepository().save(int.parse(Customer_ID[0]['customer_ID']));

  }

  @override
  void initProfilePic(String profilePicUrl) async
  {
    Photo = profilePicUrl;
    print(Photo);
  }
  @override
  Future GetMethod() async
  {
    var theUrl = Uri.parse("https://shoppeaz.000webhostapp.com/getData.php");
    var res = await http.get(theUrl, headers: {"Accept":"application/json"});
    var responsBody = json.decode(res.body);

    return responsBody;
  }
  void _setText() {

      First_name = _First_Name.text;
      Last_name = _Last_Name.text;
      Email = _Email.text;
      Password = _Password.text;


    Register();
  }
  bool _rememberMe = false;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextField(
            controller: _Email,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(
                color: Colors.white54,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFirstName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'First Name',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextField(
            controller: _First_Name,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              hintText: 'Enter your First Name',
              hintStyle: TextStyle(
                color: Colors.white54,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
          style: TextStyle(

            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextField(
            controller: _Last_Name,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              hintText: 'Enter your Last Name',
              hintStyle: TextStyle(
                color: Colors.white54,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextField(
            controller: _Password,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                color: Colors.white54,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget ChoicePhoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Choose Your Character',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      ElevatedButton(
                      onPressed: () {
                        initProfilePic("https://i.postimg.cc/bd6XfwMp/017.png");
                      },
                      child: CachedNetworkImage(
                      imageUrl: "https://i.postimg.cc/bd6XfwMp/017.png",
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 50,
                      height: 60,
                      fit: BoxFit.cover,)),
                      ElevatedButton(
                          onPressed: () {
                            initProfilePic("https://i.postimg.cc/rKzBVLXW/018.png");
                          },
                          child: CachedNetworkImage(
                            imageUrl: "https://i.postimg.cc/rKzBVLXW/018.png",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: 50,
                            height: 60,
                            fit: BoxFit.cover,)
                      ),
                      ElevatedButton(
                          onPressed: () {
                            initProfilePic("https://i.postimg.cc/kVPzv6VF/019.png");
                          },
                          child: CachedNetworkImage(
                            imageUrl: "https://i.postimg.cc/kVPzv6VF/019.png",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: 50,
                            height: 60,
                            fit: BoxFit.cover,)
                      ),
                      ElevatedButton(
                          onPressed: () {
                            initProfilePic("https://i.postimg.cc/WdkxZ641/020.png");
                          },
                          child: CachedNetworkImage(
                            imageUrl: "https://i.postimg.cc/WdkxZ641/020.png",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: 50,
                            height: 60,
                            fit: BoxFit.cover,)
                      ),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      ElevatedButton(
                          onPressed: () {
                            initProfilePic("https://i.postimg.cc/tYfL7mpc/021.png");
                          },
                          child: CachedNetworkImage(
                            imageUrl: "https://i.postimg.cc/tYfL7mpc/021.png",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: 50,
                            height: 60,
                            fit: BoxFit.cover,)),
                      ElevatedButton(
                          onPressed: () {
                            initProfilePic("https://i.postimg.cc/4KvMLfVC/022.png");
                          },
                          child: CachedNetworkImage(
                            imageUrl: "https://i.postimg.cc/4KvMLfVC/022.png",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: 50,
                            height: 60,
                            fit: BoxFit.cover,)
                      ),
                      ElevatedButton(
                          onPressed: () {
                            initProfilePic("https://i.postimg.cc/k6nHL0v2/023.png");
                          },
                          child: CachedNetworkImage(
                            imageUrl: "https://i.postimg.cc/k6nHL0v2/023.png",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: 50,
                            height: 60,
                            fit: BoxFit.cover,)
                      ),
                      ElevatedButton(
                          onPressed: () {
                            initProfilePic("https://i.postimg.cc/jwZ1TMMZ/024.png");
                          },
                          child: CachedNetworkImage(
                            imageUrl: "https://i.postimg.cc/jwZ1TMMZ/024.png",
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: 50,
                            height: 60,
                            fit: BoxFit.cover,)
                      ),
                    ]
                )
          ])
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _setText(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Register',
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

  Widget _buildSignUpWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign Up with',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => print('Login with Facebook'),
            AssetImage(
              'images/butter.jpg',
            ),
          ),
          _buildSocialBtn(
                () => print('Login with Google'),
            AssetImage(
              'images/butter.jpg',
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
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
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(height: 30.0),
                      _buildFirstName(),
                      SizedBox(height: 30.0),
                      _buildLastName(),
                      SizedBox(height: 30.0, ),

                      _buildPasswordTF(),
                      SizedBox(height: 30.0, ),
                      ChoicePhoto(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildRegisterBtn(context),


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

  void setState(Null Function() param0) {}
}

