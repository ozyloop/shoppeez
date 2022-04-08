import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favoriteChangeNotifier.dart';

class FavoriteIconWidget extends StatefulWidget {


  _FavoriteIconWidgetState createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  late dynamic recipe;

   final bool isFavorited = false;
   late bool _isFavorited = isFavorited;
  @override
   void _toggleFavorite(){
    setState(() {
      if(recipe["fk_customer_id"]==null)
      {
        _isFavorited = false;
      }
      else
      {
        _isFavorited = true;
      }});
  }
  @override
  Widget build(BuildContext context) {

    return
        IconButton(
          icon: _isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          color:Colors.red,
          onPressed: ()=>_toggleFavorite(),
        );

  }


}

class FavoriteTextWidget extends StatefulWidget {
  _FavoriteTextWidgetState createState() => _FavoriteTextWidgetState();
}

class _FavoriteTextWidgetState extends State<FavoriteTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(context,notifier, _) => Text('yo'));//notifier.favoriteCount.toString()));
  }
}