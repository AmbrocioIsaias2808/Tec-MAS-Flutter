import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/ArticleViewer.dart';
import 'package:tecmas/Secciones/SharedClasses/CustomWebview.dart';
import 'package:tecmas/main.dart';
import 'package:http/http.dart' as http;

import '../LoadingWidget.dart';

int _NotfViewsToPop=0; //Vistas de Notificaciones a cerrar

int getNotfViewsToPop(){
  return _NotfViewsToPop;
}

void addNotfViewToPop(){
  _NotfViewsToPop=_NotfViewsToPop+1;
}

void decNotfViewsToPop(dynamic context){
   Navigator.pop(context);
  _NotfViewsToPop=_NotfViewsToPop-1;
}

void resetNotfViewsToPop(){
  _NotfViewsToPop=0;
}



class NotificationArticleViewer extends StatefulWidget {
  final articleID;
  NotificationArticleViewer({this.articleID});

  @override
  _NotificationArticleViewerState createState() => _NotificationArticleViewerState(articleID: articleID);
}

class _NotificationArticleViewerState extends State<NotificationArticleViewer> {
  final articleID;
  String title="null";
  String content="null";
  bool loaded=false;

  _NotificationArticleViewerState({this.articleID});

  Future<String> renderContent({@required String Content,@required String Title, bool error=false})async{
    String Script="";
    if(error){Script="<script>function changeBackground(color) {document.body.style.background = color;} window.addEventListener('load',function() { changeBackground('white') });</script>";}
    title=Title;
    content = await rootBundle.loadString(filePath)+Script+Content+'</div></body></html>';
    setState(() {
      loaded=true;
    });
  }

  String _ErrorString_NetworkError="Al parecer experimentas alguna falla en la conexión, conectividad lenta o algo mas. En resumen no hemos podido contactar al servidor, intente mas tarde.";
  String _ErrorString_NotFound="Lo sentimos, el contenido que estas intentando encontrar no esta disponible en este momento, se ha eliminado o esta en revisión. Dispense las molestias, intente mas tarde.";
  String _ErrorString_ServerError="Ha sucedido un error del lado del servidor, dispense las molestias, intente mas tarde.";
  Future<void> ServerCall() async {

    try {
      //Base URL format: https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=CATEGORY&per_page=5&page=Pagina

      Future.delayed(Duration(milliseconds: 15000),()async{
        print("TimeOut for Connection");
        await renderContent(error: true, Title: "Error de red", Content: "<div class='notf-error-div'><p class='notf-error-msg'> Sin conexión: $_ErrorString_NetworkError</p></div>");
      });

      final response = await http.get(serverSettings.getFilterToSearchArticleByID(articleID.toString()),

        headers:{
          'Authorization':'Bearer '+serverSettings.getApiKey(),
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },


      ).timeout(Duration(seconds: 15), onTimeout: (){
        print("TimeOutBloker: \n\n\n");
      });

      //print(response.headers);



      return Future.delayed(Duration(milliseconds: 5),()async{
        print("Response: "+response.statusCode.toString());
        if (response.statusCode == 200) {
          var jsonData=json.decode(response.body);
          //print("title: "+title+" content: "+content);
          await renderContent(Title:jsonData['title']['rendered'] , Content:jsonData['content']['rendered'] );
        } else {
          // If that call was not successful, throw an error.
          if(response.statusCode==400){
            await renderContent(error:true, Title: "Error de Contenidos", Content:"<div class='notf-error-div'><p class='notf-error-msg'>$_ErrorString_ServerError</p></div>");
          }
          if(response.statusCode==404){
            await renderContent(error:true, Title: "No dispinible", Content:"<div class='notf-error-div'><p class='notf-error-msg'>$_ErrorString_NotFound</p></div>");
          }

          throw Exception("Error");
        }
      });





    } on Exception catch(e) {
      if (e.toString().contains('SocketException')) {
        await renderContent(error:true, Title: "Error de red", Content: "<div class='notf-error-div'><p class='notf-error-msg'>Algo salió mal: $_ErrorString_NetworkError </p></div>");
      }
      //do something else
    }





  }

  void fetchData()async{
    await ServerCall();
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    addNotfViewToPop();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: loaded ? CustomWebview(LoadingFromHTMLString: true, HTMLString:content , title: title, Mode: 2,) : LoadingWidget());
    //return loaded ? ArticleViewer(ArticleContent: content, title: title,) :Center(child: CircularProgressIndicator(),);
  }
}


