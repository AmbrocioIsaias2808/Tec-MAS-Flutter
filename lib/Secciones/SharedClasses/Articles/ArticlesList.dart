import 'package:flutter/cupertino.dart';
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
      ShowMoreLoadingAnimation=true;
      ServerCall();


    });

  }


  Future<List<Articles>> ServerCall() async {
    final response = await http.get(URL,
       /* headers: {
          'Authorization': 'Bearer w9ZNRvWfwUGHS1qcLvbQaMYPaeJ9GJhA',
        }*/
    );
    return Future.delayed(Duration(seconds: 1),(){

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON.
        setState(() {
          MoreHeigh=0;
          ShowMoreLoadingAnimation=false;



        });
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
      if((scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) && MoreIsVisible==false){
         setState(() {
           MoreIsVisible=true;
           print("Mostrando: ");
           print("scrollController.offset: "+scrollController.offset.toString());
           print("scrollController.position.maxScrollExtent: "+scrollController.position.maxScrollExtent.toString());
           print("scrollController.position.outOfRange: "+scrollController.position.outOfRange.toString());
           MoreHeigh=40;
         });
      }
      if((scrollController.offset < scrollController.position.maxScrollExtent) && MoreIsVisible==true){
        setState(() {
          MoreIsVisible=false;
          print("Ocultando: ");
          print("scrollController.offset: "+scrollController.offset.toString());
          print("scrollController.position.maxScrollExtent: "+scrollController.position.maxScrollExtent.toString());
          print("scrollController.position.outOfRange: "+scrollController.position.outOfRange.toString());
          MoreHeigh=0;
        });
      }




    });
    super.initState();

  }

  bool MoreIsVisible=false;
  String MoreText;
  double MoreHeigh=0;
  bool ShowMoreLoadingAnimation=false;


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: (){
        articulos.clear(); return ServerCall();
      },
       child: Column(
          children: <Widget>[
            FutureBuilder(
              future: GetArticlesFromServer,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                print(snapshot.data);
                if(snapshot.data == null){
                  return Expanded(child:
                  Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      )
                  )
                  );
                } else {
                  return Expanded(child:
                  ListView.builder(
                    controller: scrollController,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      try{
                        return cards(articulo: snapshot.data[index]);
                      }on RangeError{
                        print("Error: desplazamiento al final de lista antes de finalizar el refresh");
                      }
                    },
                  )
                  );
                }
              },
            ),
        AnimatedContainer(
          // Use the properties stored in the State class.
          width: double.infinity,
          height:MoreHeigh,

          decoration: BoxDecoration(
              //color: Color.fromRGBO(27, 55, 94,1),
              //borderRadius:BorderRadius.circular(50),
          ),
          // Define how long the animation should take.
          duration: Duration(milliseconds: 500),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
          child: ShowMoreLoadingAnimation ? Center(child: Padding(padding: EdgeInsets.all(4),child: CircularProgressIndicator(),),) : FlatButton(
            child: Text('Cargar Mas'),
            onPressed: (){
              funcReset();
            },
          ),
        )







          ]
        )


    );

  }
}
