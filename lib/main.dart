import 'package:flutter/material.dart';
import 'package:shoppeez/recipeScreen.dart';
import 'package:shoppeez/recipe.dart';
import 'package:shoppeez/recipeListScreen.dart';


import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      /*case '/newRecipe':
        return MaterialPageRoute(builder: (context) => RecipeFormScreen());*/
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

