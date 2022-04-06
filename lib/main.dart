
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shoppeez/loadingPage.dart';
import 'package:shoppeez/recipeScreen.dart';
import 'package:shoppeez/recipe.dart';
import 'package:shoppeez/recipeListScreen.dart';

import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'RecipeScreenIngredient.dart';
import 'ingredient.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shoppeez',
        initialRoute: '/',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        )
    );
  }

}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/' :
        //route to test page for database
        //return MaterialPageRoute(builder: (context) => LoadingPage());
        return MaterialPageRoute(builder: (context) => RecipeListScreen());

      case '/recipe':
        var arguments = settings.arguments;
        if (arguments != null) {
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => RecipeScreen(recipe: settings.arguments as Recipe),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                animation = CurvedAnimation(curve: Curves.ease, parent: animation);
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              }
          );
        } else {
          return pageNotFound();
        }
      case '/recipeIngredient':
        var arguments = settings.arguments;
        if (arguments != null) {
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => RecipeScreenIngredient( ingredient: settings.arguments as Ingredient),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                animation = CurvedAnimation(curve: Curves.ease, parent: animation);
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              }
          );
        } else {
          return pageNotFound();
        }
      default:
        return pageNotFound();
    }
  }

  static MaterialPageRoute pageNotFound() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(title:Text("Error"), centerTitle: true),
            body: Center(
              child: Text("Page not found"),
            )
        )
    );
  }


}

