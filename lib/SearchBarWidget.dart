
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Widget> SearchBar(context, _controller) async => TextField(
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
);