

import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppeez/main.dart';
import 'package:http/http.dart' as http;

class LoadingPage extends StatefulWidget
{
  @override
  _LoadingPage createState() => _LoadingPage();
}


class _LoadingPage extends State<LoadingPage>
{

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoppeez"),
      ),
    body: FutureBuilder(
      future: GetMethod(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot);
        print('espace');


          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching data"),
            );
          }

          List snap = snapshot.data;
          return ListView.builder(

            itemCount: snap.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("id:${snap[index]['ingredient_ID']} "),
                subtitle: Text("first name  ${snap[index]['first name']}"),//
              );
            },
          );
        }
      ),);
  }

}