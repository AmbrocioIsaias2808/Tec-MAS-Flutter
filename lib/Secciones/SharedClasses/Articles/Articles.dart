import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'cards.dart';

class Widget_Articles extends StatefulWidget {

  final String URL;

  Widget_Articles(this.URL);

  @override
  _Widget_ArticlesState createState() => _Widget_ArticlesState(URL);


}

class _Widget_ArticlesState extends State<Widget_Articles> {

  final String URL;

  _Widget_ArticlesState(this.URL){

  }


  Future<List<Articles>> ServerCall() async {
    final response = await http.get(URL);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return GetArticles(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  dynamic GetArticles(var jsonData){

    List<Articles> articulos=[];

    for(var object in jsonData){

      articulos.add(Articles(
          id: object['id'],
          title:object['title']['rendered'],
          image: object['better_featured_image']['source_url'],
          content: object['content']['rendered'],
      ));

    }

    print(articulos.length);

    return articulos;

  }



  Future<List<Articles>> GetArticlesFromServer;

  @override
  void initState() {
    super.initState();
    GetArticlesFromServer = ServerCall();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: GetArticlesFromServer,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print(snapshot.data);
          if(snapshot.data == null){
            return Container(
                child: Center(
                    child: Text("Loading...")
                )
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return cards(articulo: snapshot.data[index]);
              },
            );
          }
        },
      ),
    );

  }
}
