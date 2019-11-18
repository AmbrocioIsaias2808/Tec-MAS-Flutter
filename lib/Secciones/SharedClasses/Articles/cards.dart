import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/ArticleViewer.dart';
import 'package:tecmas/Secciones/SharedClasses/NetworkImageBox.dart';





class cards extends StatelessWidget {

  Articles articulo;

  cards({@required this.articulo});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 10,
      child: InkWell(
        focusColor: Colors.red,
        splashColor: Colors.blue,
        onTap: () {
          print(articulo.id.toString());
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
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  color:Colors.black,
                  child: NetworkImageBox(URL: articulo.image.toString()),
                )
              ),

              SizedBox(width: double.infinity,height: 10,)

            ],
          ),
        ),
      ),
    );
  }
}
