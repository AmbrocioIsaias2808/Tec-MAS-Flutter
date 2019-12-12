import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'package:tecmas/Secciones/Estructures/Databases/DBHelper.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/ArticleViewer.dart';
import 'package:tecmas/Secciones/SharedClasses/NetworkImageBox.dart';
import 'package:tecmas/Temas/BaseTheme.dart';


class cards extends StatefulWidget {
  Articles articulo;

  cards({@required this.articulo});

  @override
  _CardsState createState() => _CardsState(articulo: articulo);
}

class _CardsState extends State<cards> {


  Articles articulo;
  bool _isSaved=false;
  var DB = DBHelper();

  _CardsState({@required this.articulo});

  void isSavedCheck() async{
    //Nota: ver si es necesario poner un delay para tener una carga mas fluida
    if(await DB.isThisArticleSaved(articulo.num)){
      setState((){_isSaved=true;});
    }else{
      setState((){_isSaved=false;});
    }



  }

  @override
  void initState(){
    isSavedCheck();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: BaseThemeColor_LightGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 10,
      child: InkWell(
        focusColor: Colors.red,
        splashColor: Colors.blue,
        onTap: () {
          print(articulo.num.toString());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArticleViewer(title:articulo.title.toString(),ArticleContent:articulo.content)),
          );
        },
        child: Container(

          width: double.infinity,
          child: Column(

            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
              child:Text(articulo.title.toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.black,
                      ),
                      child: NetworkImageBox(URL: articulo.image.toString()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width-60,145, 15, 0),
                    child: FloatingActionButton(
                      heroTag: articulo.ID.toString(),
                      child: Icon(Icons.favorite,color: Colors.white,),
                      elevation: 20.0,
                      backgroundColor: _isSaved ? Colors.red:Colors.blueGrey,
                      splashColor: Colors.red,
                      onPressed: ()async{
                        print(articulo.title);

                        if(_isSaved){
                          DB.deleteSavedArticle(articulo.num); //Borra por el num de articulo en wordpress no el id en nuestra base de datos
                          setState(() {_isSaved=false;});
                        }else{
                          setState(() {_isSaved=true;});
                          DB.saveArticle(articulo);
                        }
                        },
                    ),
                  )

                ],
              ),

              SizedBox(width: double.infinity,height: 10,)

            ],
          ),
        ),
      ),
    );
  }
}
