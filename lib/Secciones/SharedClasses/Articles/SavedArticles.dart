import "package:flutter/material.dart";
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'package:tecmas/Secciones/Estructures/Databases/DBHelper.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

import 'cards.dart';

class SavedArticles extends StatefulWidget {
  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {

  Future<List<Articles>> savedArticles;

  double MoreHeigh=0;
  final scrollController= ScrollController();
  bool MoreIsVisible=false;

  var DB = DBHelper();

  Future<List<Articles>> LoadFromDatabase() async {
    setState(() {
      savedArticles = DB.getSavedArticulos();
    });
  }

  @override
  void initState(){
    LoadFromDatabase();
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

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          FutureBuilder(
            future: savedArticles,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              //print(snapshot.data);

              return (snapshot.connectionState == ConnectionState.done) ? //Si la conexión a terminado y
              (snapshot.hasData) ?//Se han obtenido datos de la consulta
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
                          icon: Icon(Icons.refresh),
                          label:Text("Tu lista esta vacía"),
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
            child: FlatButton(
              child: Text("Estos son todos los Articulos", style: BaseThemeText_whiteBold1),
            ),
          )







        ]
    );
  }
}
