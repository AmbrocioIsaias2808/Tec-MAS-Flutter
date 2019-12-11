import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:tecmas/Secciones/Estructures/Databases/DBHelper.dart';
import 'package:tecmas/Secciones/SharedClasses/CommonlyUsedFunctions.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/Errors/MSG_NetworkConnectionError.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'dart:convert';

import 'cards.dart';

class ArticlesList extends StatefulWidget {

  final String URL;
  final int Category;
  _ArticlesListState State;


  ArticlesList({@required this.URL, @required this.Category}){
    State= new _ArticlesListState(URL, Category);
  }

  @override
  _ArticlesListState createState() => State;


}

class _ArticlesListState extends State<ArticlesList> {

  final String ApiKey="wFx01QuHh9ybSx82rzZvypurEs1HQpWy"; //Server
  //final String ApiKey="eeOpx2D5gHJdPzmjF15UY2JBZgcDsBaj"; //Local
  final String URL;
  final int Category;
  var DB = DBHelper();

  _ArticlesListState(this.URL, this.Category){

  }


  dynamic funcReset(){
    setState(() {
      ShowMoreLoadingAnimation=true;
      ServerCall();
    });

  }




  Future<List<Articles>> ServerCall() async {

    try {
      //Base URL format: https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=CATEGORY&per_page=5&page=Pagina

      final response = await http.get(URL+Category.toString()+"&per_page=5&page="+Pagina.toString(),

          headers:{
             'Authorization':'Bearer '+ApiKey,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            },
      );

      //print(response.headers);



      return Future.delayed(Duration(milliseconds: 5),(){
        print("Response: "+response.statusCode.toString());
        if (response.statusCode == 200) {
          // If the call to the server was successful, parse the JSON.
          setState(() {
            networkError=false;
            MoreHeigh=0;
            ShowMoreLoadingAnimation=false;
            databaseload=false;



          });

          return GetArticles(json.decode(response.body));
        } else {
          // If that call was not successful, throw an error.
          if(response.statusCode==400){

            /*Nota del desarrollador - Apuntes Personales
          *
          * Me sugiero a mi mismo personalizar mediante excepciones personalidas este tipo de errores.
          * */
            setState(() {
              isAllArticlesDisplayed=true;
              ShowMoreLoadingAnimation=false;
            });
          }

          throw Exception("Error");
        }

      });













    } on Exception catch(e) {
      if (e.toString().contains('SocketException')) {
        setState(() {
          networkError=true;
        });
    }
    //do something else
    }





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

      Articles a = Articles(
        ID:int.parse(Category.toString()+object["id"].toString()),
        num: object['id'],
        title:object['title']['rendered'],
        image: image,
        content: object['content']['rendered'],
        category: Category,
      );

      articulos.add(a);
      DB.insert(a);
    }
    setState(() {
      isRefreshing=false;
    });
    //print(DB.getArticulos(Category));
    //database=DB.getArticulos(Category);
    //print("DatabaseLoad state: "+databaseload.toString()+" and Articulos: "+articulos.length.toString());
    return articulos;

  }



  Future<List<Articles>> GetArticlesFromServer;
  Future<List<Articles>> database;
  final scrollController= ScrollController();

  @override
  void initState(){
    InitialDataSource();
    scrollController.addListener((){
      if((scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) && MoreIsVisible==false){
         setState(() {
           MoreIsVisible=true;
           MoreHeigh=40;
         });
      }
      if((scrollController.offset < scrollController.position.maxScrollExtent) && MoreIsVisible==true){
        setState(() {
          MoreIsVisible=false;
          MoreHeigh=0;
        });
      }




    });
    super.initState();

  }

  void InitialDataSource() async{
        if(await networkConnectionCkeck()==1) {
          print("Loading from internet");
          DB.deleteAllByCategory(Category);// por ahora
          GetArticlesFromServer = ServerCall();
        }else{
          setState(() {
            print("Loading from database");
            database=DB.getArticulos(Category);
            print(database);
            databaseload=true;
            Future.delayed(Duration(milliseconds: 1000),(){
              Scaffold.of(context).showSnackBar(MSG_MostrandoBD);
            });

          });

        }
  }

  bool MoreIsVisible=false;
  String MoreText;
  double MoreHeigh=0;
  bool ShowMoreLoadingAnimation=false;
  int Pagina=1; //Variable de paginación de resultados
  bool isAllArticlesDisplayed=false;
  bool networkError=false;
  bool isRefreshing=false;
  bool databaseload=false;
  bool intent=false;
  final MSG_MostrandoBD = SnackBar(backgroundColor: BaseThemeColor_DarkBlue,content: Text("Lo siento, no he podido contactar al servidor. Estoy mostrando los resultados mas recientes guardados en memoria.",
                          style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.justify,));


  void AnimacionDeIntentoDeConexion(){
    setState((){
      intent=true;
      print(intent);
    });

    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        intent=false;
        print(intent);
      });
    });
  }

  void Refresh(){
      DB.deleteAllByCategory(Category);
      //DB.deleteALL();
      articulos.clear(); Pagina=1; isAllArticlesDisplayed=false;
  }

  /*Future networkConnectionCkeck() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return 1;
      }
    } on SocketException catch (_) {
      setState(() {
        networkError=true;
      });
      return 0;
    }
  }*/

  Future networkConnectionCkeck() async{
    int netState = await NetworkConnectionCkeck();
    if(netState==0){
      setState(() {
        networkError=true;
      });
    }
    return netState;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator (
      onRefresh: ()async{

                    if(MoreIsVisible==false && ShowMoreLoadingAnimation==false && await networkConnectionCkeck()==1){

                      setState(() {
                        isRefreshing=true;
                      });
                      Refresh(); if(databaseload==true){InitialDataSource();}else{return ServerCall();}
                    }else{
                      return Future.delayed(Duration(milliseconds: 5),(){
                        Scaffold.of(context).showSnackBar(MSG_MostrandoBD);
                        //print("Feature disable or network connection error");
                      });
                    }
      },
       child: Column(
          children: <Widget>[
            FutureBuilder(
              future: databaseload ? database : GetArticlesFromServer,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                //print(snapshot.data);

                return (snapshot.connectionState == ConnectionState.done) ? //Si la conexión a terminado y
                    (snapshot.hasData &&  (networkError==false || databaseload==true)) || (snapshot.hasData==false && articulos.length!=0) || (articulos.length!=0) ?//Se han obtenido datos de la consulta
                     /* Y la peticion fue satisfactoria*/
                       /*Despliega el sig elemento*/
                        Expanded(child:
                          ListView.builder(
                            controller: scrollController,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              try{
                                return cards(articulo: snapshot.data[index]);
                              }on RangeError{
                                //print("Error: desplazamiento al final de lista antes de finalizar el refresh");
                              }
                            },
                          )
                        )
                    : /*Si sucesido algun error despliega el siguiente elemento*/

                Expanded(child: Center(
                  child:Column(children: <Widget>[
                    SizedBox(height: 200, width: double.infinity,),
                    Container(

                        child:FloatingActionButton.extended(
                        icon: Icon(Icons.network_check),
                        label:Text("Error Inesperado ¿Reintentar?"),
                        onPressed: () => setState(() {
                          initState();
                        })
                    ))
                  ],),
                ) ,)




                    : /*Si no tengo información y la conexion no ha terminado entonces muestro el icono de loading*/
                Expanded(child:
                        Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            )
                        )
                        );
























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
          child: (ShowMoreLoadingAnimation && networkError==false) || intent? Center(child: Padding(padding: EdgeInsets.all(4),child: CircularProgressIndicator(),),) : FlatButton(
            child: isAllArticlesDisplayed ? Text("Estos son todos los Articulos", style: BaseThemeText_whiteBold1) : networkError ? Text("Error de Red ¿Reintentar?", style: BaseThemeText_whiteBold1,) : Text('Cargar Mas', style: BaseThemeText_whiteBold1),
            onPressed: ()async {
              if((isAllArticlesDisplayed==false && isRefreshing==false) && await networkConnectionCkeck()==1){
                  if(databaseload==true){
                    AnimacionDeIntentoDeConexion();
                    InitialDataSource();
                  }else{
                    Pagina++;
                    funcReset();
                  }
              }else{
                    AnimacionDeIntentoDeConexion();
              }

            },
          ),
        )







          ]
        )


    );

  }
}
