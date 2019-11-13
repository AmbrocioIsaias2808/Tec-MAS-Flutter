import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'cards.dart';

class ArticlesList extends StatefulWidget {

  final String URL;
  _ArticlesListState State;


  void ServerCall(){
    State.ServerCall();
  }

  ArticlesList({@required this.URL}){
    State= new _ArticlesListState(URL);
  }

  @override
  _ArticlesListState createState() => State;


}

class _ArticlesListState extends State<ArticlesList> {

  final String URL;

  _ArticlesListState(this.URL){

  }


  dynamic funcReset(){
    setState(() {
      ServerCall();
    });

  }


  Future<List<Articles>> ServerCall() async {
    final response = await http.get(URL);
    return Future.delayed(Duration(seconds: 1),(){

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON.
        return GetArticles(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }

    });

  }

  List<Articles> articulos=[];

  dynamic GetArticles(var jsonData){



    for(var object in jsonData){

      String image;
      try{
      image=object['better_featured_image']['source_url'];
      }
      catch(error){
        image="http://4.bp.blogspot.com/-p3mTTSmKMp8/Uy8UOe2P2YI/AAAAAAAAKLk/6Ewj_FPUXqs/s1600/probando.jpg";
      }

      articulos.add(Articles(
          id: object['id'],
          title:object['title']['rendered'],
          image: image,
          content: object['content']['rendered'],
      ));

    }

    print(articulos.length);

    return articulos;

  }



  Future<List<Articles>> GetArticlesFromServer;
  final scrollController= ScrollController();

  @override
  void initState() {
    GetArticlesFromServer = ServerCall();
    scrollController.addListener((){
      if(scrollController.position.maxScrollExtent==scrollController.offset){
        print("final");

        funcReset();
      }
    });
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: (){
        articulos.clear(); return ServerCall();
      },
       child: Container(
          child: FutureBuilder(
            future: GetArticlesFromServer,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              print(snapshot.data);
              if(snapshot.data == null){
                return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    )
                );
              } else {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: snapshot.data.length+1,
                  itemBuilder: (BuildContext context, int index) {
                    if(index<articulos.length) {
                      return cards(articulo: snapshot.data[index]);
                    }/*else{
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }*/
                  },
                );
              }
            },
          ),
        )


    );

  }
}
