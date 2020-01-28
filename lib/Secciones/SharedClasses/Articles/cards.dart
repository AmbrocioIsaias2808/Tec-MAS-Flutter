import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'package:tecmas/Secciones/Estructures/Databases/DBHelper.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/ArticleViewer.dart';
import 'package:tecmas/Secciones/SharedClasses/NetworkImageBox.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'package:share/share.dart';

import '../CommonlyUsed.dart';


class cards extends StatefulWidget {
  Articles articulo;
  bool likeEnable;

  cards({@required this.articulo, @required this.likeEnable});

  @override
  _CardsState createState() => _CardsState(articulo: articulo, likeEnable: likeEnable);
}

class _CardsState extends State<cards> {


  Articles articulo;
  bool likeEnable;
  bool _isSaved=false;
  var DB = DBHelper();

  _CardsState({@required this.articulo, @required this.likeEnable});

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
      elevation: 20,
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
                    child: likeEnable ?
                    FloatingActionButton(
                      heroTag: DateTime.now().millisecondsSinceEpoch.toString(),
                      child: Icon(Icons.favorite,color: Colors.white,),
                      elevation: 20.0,
                      backgroundColor: _isSaved ? Colors.red:Colors.blueGrey,
                      splashColor: Colors.red,
                      onPressed: ()async{
                        print(articulo.title);

                        if(_isSaved){
                          await DB.deleteSavedArticle(articulo.num); //Borra por el num de articulo en wordpress no el id en nuestra base de datos
                          setState(() {_isSaved=false;});
                          ShowSnackWithDelay(context, 1000, BasicSnack("Elemento eliminado de tu lista de favoritos"));

                        }else{
                          setState(() {_isSaved=true;});
                          await DB.saveArticle(Articles.CreateAndSave(num: articulo.num, image: articulo.image, title: articulo.title, content: articulo.content, date: DateTime.now().millisecondsSinceEpoch, url: articulo.url ));
                          ShowSnackWithDelay(context, 1000, BasicSnack("Elemento guardado en tu lista de favoritos"));

                        }
                      },
                    )
                        : null,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width-60,0, 15, 0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      heroTag: UniqueKey(),
                      child: Icon(Icons.share, color:Colors.white),
                      elevation: 20,
                      onPressed: (){Share.share("Noticias TecNM Matamoros\n\n"+articulo.title.toString()+": "+articulo.url.toString());},
                    ),
                  ),

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
