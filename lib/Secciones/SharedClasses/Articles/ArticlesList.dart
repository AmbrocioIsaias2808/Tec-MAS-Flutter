import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:tecmas/Secciones/Estructures/Databases/DBHelper.dart';
import 'package:tecmas/Secciones/SharedClasses/CommonlyUsed.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/BasicMSGDialog.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'package:tecmas/main.dart';
import 'dart:convert';

import '../LoadingWidget.dart';
import 'cards.dart';

dynamic _ListArticlesContext; /*Variable que almacena el context de esta vista necesaria para cerrar los snackbars antes de pasar
 a la ventana de SavedArticles o articulos guardados ("favoritos")*/

dynamic getArticlesListContext(){
  return _ListArticlesContext; //Como debe ser una varianble privada la regreso con este getter

  //A su vez, el el initState de  _ArticlesListState debo inicializar esta variable.
}

class ArticlesList extends StatefulWidget {

  final int Category;
  _ArticlesListState State;



  ArticlesList({@required this.Category});

  @override
  _ArticlesListState createState() => _ArticlesListState(Category);


}

class _ArticlesListState extends State<ArticlesList> with AutomaticKeepAliveClientMixin<ArticlesList>{

  final int Category;
  bool hasData;
  var DB = DBHelper();

  _ArticlesListState(this.Category){

  }

  void StopLoadingProcess(){
    print("Stoping process");
    setState(() {
      isRefreshing=false;
      ShowMoreLoadingAnimation=false;
      networkError=true;
    });
  }


  Future<List<Articles>> ServerCall() async {

    try {
      //Base URL format: https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=CATEGORY&per_page=5&page=Pagina

      Future.delayed(Duration(milliseconds: 15000),(){
        print("TimeOut for Connection");
          if (networkConnectionCkeck()==1){
            setState(() {
              print("Time out for connection, to much time for contact");
              isRefreshing=false;
              ShowMoreLoadingAnimation=false;
            });
          }
      });

      final response = await http.get(serverSettings.PaginarPorCategoria(cantidadAMostrar: "5", NumDePagina: Pagina.toString(), categoriaAFiltrar: Category.toString()),

          headers:{
             'Authorization':'Bearer '+serverSettings.getApiKey(),
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            },


      ).timeout(Duration(seconds: 15), onTimeout: (){
        print("TimeOutBloker: \n\n\n");
        StopLoadingProcess();
        print("To much time to contact");
        //Pagina=Pagina-1; if(Pagina==0){Pagina=1;}
        //print("Pagina: "+(Pagina-1).toString()+"but error happend so decressed: "+(Pagina).toString());
      });

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
          * Me sugiero a mi mismo personalizar mediante excepciones este tipo de errores.
          * */
            setState(() {
              isAllArticlesDisplayed=true;
              ShowMoreLoadingAnimation=false;
            });
          }
          if(response.statusCode==404){
            StopLoadingProcess();
          }

          throw Exception("Error");
        }

      });













    } on NoSuchMethodError catch(e){
      print("Error: "+e.toString());
      StopLoadingProcess();
    }on Exception catch(e) {
      print("Excepcion: "+e.toString());
      /*if (e.toString().contains('SocketException')) {
        setState(() {
          networkError=true;
        });
    }*/
      StopLoadingProcess();
    //do something else
    }catch(e){
      StopLoadingProcess();
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
        image="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRBZNpdaxzwE4Tehk16HHWNFRSxwXzKjhptSz-JrSwkIGD2QO68";
      }

      Articles a = Articles(
        ID:int.parse(Category.toString()+object["id"].toString()),
        num: object['id'],
        title:object['title']['rendered'],
        image: image,
        content: object['content']['rendered'],
        category: Category,
        url:object["link"],
      );

      try {
        articulos.add(await DB.insert(a));
      }on Exception catch(e){
        StopLoadingProcess();
        print("Execption");
        return articulos;
      }catch(e){
        print("Database error: "+e.toString());
        StopLoadingProcess();
        return articulos;
      }


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



  Future<List> GetArticlesFromServer;
  final scrollController= ScrollController();

  int NumOfArticlesOnDatabase;
  @override
  void initState(){
    _ListArticlesContext=context; //Incializo el contexto para hacer ciertas operaciones en el widget padre
    NumOfArticlesOnDatabase=0;
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

  void loadFromDatabase()async{
    articulos= await DB.getArticulos(Category);
    setState(() {
              print("Loading from database");
              GetArticlesFromServer= Future.delayed(Duration(microseconds: 0), (){return articulos;});
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
                  int num=await DB.CountOfArticlesSavedOnDB(Category);
                  setState((){
                    NumOfArticlesOnDatabase = num;
                  });
                  print("Loading from Database count: "+NumOfArticlesOnDatabase.toString());

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

  Future networkConnectionCkeck() async{
    int netState = await NetworkConnectionCkeck();
    if(netState==0){
      StopLoadingProcess();
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
                print("Enter Builder: "+NumOfArticlesOnDatabase.toString());

                return (snapshot.connectionState == ConnectionState.done) ? //Si la conexión a terminado y
                (snapshot.hasData && articulos.isNotEmpty) || (databaseload==true && NumOfArticlesOnDatabase!=0) ?//Se han obtenido datos de la consulta
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
                  child:articulos.isEmpty && isRefreshing?
                  BasicMSGDialog(Title: "Conectando...", Description: "Espera unos momentos por favor", ButtonText: "Reiniciar Conexión", MessegeType: 4, ButtonAction:(){initState();}, ButtonColor: Colors.green,ButtonTextColor: Colors.white, )
                      :
                  BasicMSGDialog(Title: "Oooops!!", Description: "Algo salio mal, es probable que aún no haya contendio o un error se produjo al contactar al servidor ", ButtonText: "¿Reintentar?", MessegeType: 2, ButtonAction: (){initState();}, ButtonColor: Colors.orange, ButtonTextColor: Colors.white,)
                ) ,)




                    : /*Si no tengo información y la conexion no ha terminado entonces muestro el icono de loading*/
                Expanded(child:LoadingWidget());
























              },
            ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, MoreHeigh>0?48:0),
          child: AnimatedContainer(
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
              child: isAllArticlesDisplayed ? Text("Estos son todos los Articulos", style: BaseThemeText_TxtColorBold1) : networkError ? Text("Error de Red ¿Reintentar?", style: BaseThemeText_TxtColorBold1,) : Text('Cargar Mas', style: BaseThemeText_TxtColorBold1),
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
                    if(!networkError){Pagina++;}else{networkError=false;}
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
          ),
        )







          ]
        )


    );

  }

  @override
  bool get wantKeepAlive => true;
}
