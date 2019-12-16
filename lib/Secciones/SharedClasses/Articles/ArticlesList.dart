import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:tecmas/Secciones/Estructures/Databases/DBHelper.dart';
import 'package:tecmas/Secciones/SharedClasses/CommonlyUsed.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/Errors/MSG_NetworkConnectionError.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'dart:convert';

import 'cards.dart';

class ArticlesList extends StatefulWidget {

  final String URL;
  final int Category;
  _ArticlesListState State;



  ArticlesList({@required this.URL, @required this.Category});

  @override
  _ArticlesListState createState() => _ArticlesListState(URL, Category);


}

class _ArticlesListState extends State<ArticlesList> with AutomaticKeepAliveClientMixin<ArticlesList>{

  final String ApiKey="wFx01QuHh9ybSx82rzZvypurEs1HQpWy"; //Server
  //final String ApiKey="eeOpx2D5gHJdPzmjF15UY2JBZgcDsBaj"; //Local
  final String URL;
  final int Category;
  bool hasData;
  var DB = DBHelper();

  _ArticlesListState(this.URL, this.Category){

  }


  Future<List<Articles>> ServerCall() async {

    try {
      //Base URL format: https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=CATEGORY&per_page=5&page=Pagina

      Future.delayed(Duration(milliseconds: 30000),(){
        networkConnectionCkeck();
      });

      final response = await http.get(URL+Category.toString()+"&per_page=5&page="+Pagina.toString(),

          headers:{
             'Authorization':'Bearer '+ApiKey,
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            },
      );

      //print(response.headers);



      return Future.delayed(Duration(milliseconds: 5),()async{
        print("Response: "+response.statusCode.toString());
        if (response.statusCode == 200) {
          // If the call to the server was successful, parse the JSON.
          setState(() {
            networkError=false;
            MoreHeigh=0;
            ShowMoreLoadingAnimation=false;
            databaseload=false;



          });

          return await GetArticles(json.decode(response.body));
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

  dynamic GetArticles(var jsonData) async{

  var object;

    for(object in jsonData){

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

      articulos.add(await DB.insert(a));


    }


    setState(() {
      isRefreshing=false;
      hasData=true;
    });
    //print(DB.getArticulos(Category));
    //database=DB.getArticulos(Category);
    //print("DatabaseLoad state: "+databaseload.toString()+" and Articulos: "+articulos.length.toString());
    return articulos;

  }



  Future<List<Articles>> GetArticlesFromServer;
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

  void loadFromDatabase(){
    setState(() {
              print("Loading from database");
              GetArticlesFromServer=DB.getArticulos(Category);
              print(GetArticlesFromServer);
              databaseload=true;
              ShowSnackWithDelay(context, 1000, BasicSnack(MSG_MostrandoBD));
    });
  }

  void InitialDataSource() async{
                if(await networkConnectionCkeck()==1) {
                  print("Loading from internet");
                    setState(() {
                      hasData=false;
                    });
                    articulos.clear(); Pagina=1; isAllArticlesDisplayed=false;
                    await DB.deleteAllByCategory(Category);// por ahora
                  GetArticlesFromServer = ServerCall();
                }else{
                  loadFromDatabase();

                }

  }

  bool MoreIsVisible=false;
  double MoreHeigh=0;
  bool ShowMoreLoadingAnimation=false;
  int Pagina=1; //Variable de paginación de resultados
  bool isAllArticlesDisplayed=false;
  bool networkError=false;
  bool isRefreshing=false;
  bool databaseload=false;
  final String MSG_MostrandoBD = "Lo siento, no he podido contactar al servidor.";


  /*void ShowMoreLoadingAnimationManualControl(){
    setState((){
      print(ShowMoreLoadingAnimation);
     ShowMoreLoadingAnimation=true;
    });

    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        ShowMoreLoadingAnimation=false;
        print(ShowMoreLoadingAnimation);
      });
    });
  }*/


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
        isRefreshing=false;
        networkError=true;
      });
    }
    return netState;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator (
      onRefresh: ()async{

                    setState(() {
                      isRefreshing=true;
                    });

                    if(MoreIsVisible==false && ShowMoreLoadingAnimation==false && await networkConnectionCkeck()==1){
                     await InitialDataSource();
                    }else{
                      return  ShowSnackWithDelay(context, 1000, BasicSnack(MSG_MostrandoBD));
                    }
      },
       child: Column(
          children: <Widget>[
            FutureBuilder(
              future: GetArticlesFromServer,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                //print(snapshot.data);

                return (snapshot.connectionState == ConnectionState.done) ? //Si la conexión a terminado y
                    snapshot.hasData && articulos.isNotEmpty ?//Se han obtenido datos de la consulta
                     /* Y la peticion fue satisfactoria*/
                       /*Despliega el sig elemento*/
                        Expanded(child:
                          ListView.builder(
                            controller: scrollController,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              try{
                                return cards(articulo: snapshot.data[index], likeEnable: true);
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
                        icon: articulos.isEmpty && isRefreshing? Icon(Icons.airplay):Icon(Icons.network_check),
                        label: articulos.isEmpty && isRefreshing?Text("Conectando al servidor"):Text("Error Inesperado ¿Reintentar?"),
                        onPressed: () => setState(() {
                          articulos.isEmpty && isRefreshing==false?initState():null;
                        })
                    ))
                  ],),
                ) ,)




                    : /*Si no tengo información y la conexion no ha terminado entonces muestro el icono de loading*/
                Expanded(child:
                        Container(
                            child: Center(
                              child: SizedBox(
                                height: 100,
                                child: Stack(
                                  children: <Widget>[
                                        Center(
                                          child: Container(
                                            height: 100,width: 100,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                    Center(child:
                                      Text("Cargando", style: BaseThemeText_whiteBold1,),
                                    )
                                  ],
                                ),
                              ),
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
          child: ShowMoreLoadingAnimation ? Center(child: Padding(padding: EdgeInsets.all(4),child: CircularProgressIndicator(),),) : FlatButton(
            child: isAllArticlesDisplayed ? Text("Estos son todos los Articulos", style: BaseThemeText_whiteBold1) : networkError ? Text("Error de Red ¿Reintentar?", style: BaseThemeText_whiteBold1,) : Text('Cargar Mas', style: BaseThemeText_whiteBold1),
            onPressed: ()async {
              int NetworkAvailable= await networkConnectionCkeck();
              print("Network: "+ NetworkAvailable.toString()+" isAllArticlesDisplay: "+ isAllArticlesDisplayed.toString()+" isRefreshing: "+isRefreshing.toString());
              if((isAllArticlesDisplayed==false && isRefreshing==false) && NetworkAvailable==1){
                  if(databaseload==true){

                    setState((){ShowMoreLoadingAnimation=true;});
                    await InitialDataSource();
                    Future.delayed(Duration(milliseconds: 500),(){
                      setState(() {ShowMoreLoadingAnimation=false;});
                    });

                  }else{
                        //Aumento la paginación y solicito los datos al servidor
                        Pagina++;
                        setState(() {
                          ShowMoreLoadingAnimation=true;
                          ServerCall();
                        });
                  }
              }else{
                print("Lanzando aqui");
                    setState((){ShowMoreLoadingAnimation=true;});
                    Future.delayed(Duration(milliseconds: 500),(){
                      setState(() {ShowMoreLoadingAnimation=false;});
                    });
              }

            },
          ),
        )







          ]
        )


    );

  }

  @override
  bool get wantKeepAlive => true;
}
