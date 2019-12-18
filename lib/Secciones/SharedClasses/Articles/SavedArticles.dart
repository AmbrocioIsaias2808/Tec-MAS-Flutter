import "package:flutter/material.dart";
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'package:tecmas/Secciones/Estructures/Databases/DBHelper.dart';
import 'package:tecmas/Secciones/SharedClasses/CommonlyUsed.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

import 'cards.dart';


class SavedArticles extends StatefulWidget {
  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles>{

  List<Map> maps;
  int numOfArticles=-1;

  List<Articles> articulos=[];

  double MoreHeigh=0;
  final scrollController= ScrollController();
  bool MoreIsVisible=false;

  var DB = DBHelper();

  void getArticulos()async{
    maps=await DB.getSavedArticulos();

    for (int i=0; i<maps.length;i++){
      articulos.add(Articles.savedFromMap(maps[i]));
    }
    setState(() {
      numOfArticles=maps.length;
    });
  }


  void onDelete(dynamic context,int index)async{
    await DB.deleteSavedArticle(articulos[index].num);
    ShowSnackWithDelay(context,0,BasicSnack("Elemento borrado correctamente."));
    articulos.removeAt(index);
    setState(() {
      numOfArticles--;
    });
  }


  @override
  void initState(){
    getArticulos();
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

  dynamic _key= UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _key,
        title: Text("Artículos Guardados"),
      ),
      body: Column(
          children: <Widget>[
            Expanded(child: numOfArticles == -1
                ? Center(child: Text("Hola Mundo"),)
                : numOfArticles > 0 ?
            ListView.builder(
              controller: scrollController,
              itemCount: numOfArticles,
              itemBuilder: (BuildContext context, int index) {
                try {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                      color: Colors.redAccent,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    child: cards(articulo: articulos[index], likeEnable: false),
                    onDismissed: (direction) {
                      onDelete(context, index);
                    },
                  );
                } on RangeError {
                  //print("Error: desplazamiento al final de lista antes de finalizar el refresh");
                }
              },
            ) : Center(child: Text("Nada que mostrar aún",style: BaseThemeText_whiteBold1 ),),
            ),
            numOfArticles >0 ?AnimatedContainer(
              // Use the properties stored in the State class.
              width: double.infinity,
              height: MoreHeigh,

              decoration: BoxDecoration(
                //color: Color.fromRGBO(27, 55, 94,1),
                //borderRadius:BorderRadius.circular(50),
              ),
              // Define how long the animation should take.
              duration: Duration(milliseconds: 500),
              // Provide an optional curve to make the animation feel smoother.
              curve: Curves.fastOutSlowIn,
              child: FlatButton(
                child: Text("Estos son todos los Articulos",
                    style: BaseThemeText_whiteBold1),
              ),
            ):SizedBox(),


          ]
      ),
    );
  }
}
