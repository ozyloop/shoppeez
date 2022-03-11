

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:shoppeez/ingredient.dart';
import 'package:sqflite/sqflite.dart';

class IngredientDataBase {
  IngredientDataBase._();

  static final IngredientDataBase instance = IngredientDataBase._();
  static Database? _database;


  Future<Database> get database async => _database??= await initDB();


  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join( await getDatabasesPath(), 'ingredient_database.db'),
      onCreate: (db, version) {
        return db.execute(
          //ligne pour créer une base de donner
          "CREATE TABLE ingredient(name TEXT PRIMARY KEY, type TEXT, imageUrl TEXT, description TEXT,  quantity INTEGER)",
        );
      },
      version: 1,
    );
  }

  void insertIngredient(Ingredient ingredient) async {
    final Database db = await database;

    await db.insert(
      'ingredient',
      ingredient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateIngredient(Ingredient ingredient) async {
    final Database db = await database;
    await db.update("ingredient", ingredient.toMap(),
        where: "name = ?", whereArgs: [ingredient.name]);
  }

  void deleteIngredient(String title) async {
    final Database db = await database;
    db.delete("ingredient", where: "name = ?", whereArgs: [title]);
  }
  Future<List<Ingredient>> ingredients() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ingredient');
    List<Ingredient> ingredients = List.generate(maps.length, (i) {
      return Ingredient.fromMap(maps[i]);
    });

    if(ingredients.isEmpty) {
      for(Ingredient ingredient in defaultIngredients) {
        insertIngredient(ingredient);
      }
      ingredients = defaultIngredients;
    }
    return ingredients;
  }}
final List<Ingredient> defaultIngredients = [ Ingredient(
  "Butter",
  "dairy",
  "images/butter.jpg",
  3,

),
  Ingredient(
    "Cabbages",
    "vegetables",
    "images/cabbage.jpeg",
    3,

  ),
  Ingredient(
    "Carrots",
    "vegetables",
    "images/carrot.jpg",
    3,

  ),
  Ingredient(
    "Chickens",
    "animal products",
    "images/chicken.jpg",
    3,

  ),
  Ingredient(
    "Chocolate",
    "dairy",
    "images/chocolate.jpg",
    3,

  ),
  Ingredient(
    "Chocolate2",
    "dairy",
    "images/chocolate2.jpeg",
    3,

  ),
  Ingredient(
    "Cinnamon",
    "spices",
    "images/cinnamon.jpg",
    3,

  ),
  Ingredient(
    "Cucumbers",
    "vegetables",
    "images/cucumber.jpeg",
    3,

  ),
  Ingredient(
    "Eggs",
    "animal products",
    "images/egg.jpg",
    3,

  ),
  Ingredient(
    "Flour",
    "grains",
    "images/flour.jpg",
    3,

  ),
  Ingredient(
    "Lemons",
    "fruits",
    "images/lemon.jpeg",
    3,

  ),
  Ingredient(
    "Beef",
    "animal products",
    "images/meat_cow.jpg",
    3,

  ),
  Ingredient(
    "Minced Meat",
    "animal products",
    "images/minced_meat.jpg",
    3,

  ),
  Ingredient(
    "Onions",
    "vegetables",
    "images/onion.jpg",
    3,

  ),
  Ingredient(
    "Pepper",
    "spices",
    "images/pepper.jpeg",
    3,

  ),
  Ingredient(
    "Potatoes",
    "vegetables",
    "images/potato.jpg",
    3,

  ),
  Ingredient(
    "Salt",
    "spices",
    "images/salt.jpg",
    3,

  ),
  Ingredient(
    "Strawberry",
    "fruits",
    "images/strawberry.jpeg",
    3,

  ),
  Ingredient(
    "Sugar",
    "spices",
    "images/sugar.jpg",
    3,

  ),
  Ingredient(
    "Tomatoes",
    "vegetables",
    "images/tomato.jpeg",
    3,

  ),

];


