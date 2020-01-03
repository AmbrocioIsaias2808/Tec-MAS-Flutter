import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecmas/Secciones/Estructures/Articles.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/ArticleViewer.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/Widget_Articles.dart';
import 'package:tecmas/Secciones/SharedClasses/CustomWebview.dart';
import 'package:tecmas/Secciones/SharedClasses/Messeges/BasicMSGDialog.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'package:tecmas/main.dart';
import 'package:http/http.dart' as http;
import 'package:giffy_dialog/giffy_dialog.dart';
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
  int _errorType=0;
  String _ErrorTitle;
  String _ErrorDescription;
  dynamic _ButtonColor=Colors.orange;
  bool DialogDismiss=true;

  _NotificationArticleViewerState({this.articleID});

  Future<String> renderContent({@required String Content,@required String Title, bool error=false})async{
    String Script="";
    if(error){Script="<script>function changeBackground(color) {document.body.style.background = color;} window.addEventListener('load',function() { changeBackground('white') });</script>";}
    title=Title;
    content = await rootBundle.loadString(filePath)+Script+Content+'</div></body></html>';
    setState(() {
      DialogDismiss=true;
      loaded=true;
    });
  }

  void SetErrorDialog(int ErrorType){
    _errorType=ErrorType;
    if(_errorType==1){
      _ErrorTitle="Error de red";
      _ErrorDescription=_ErrorString_NetworkError;
    } else if(_errorType==2){
      _ErrorTitle="Error de Contenidos";
      _ErrorDescription=_ErrorString_ServerError;
    }else if(_errorType==3){
      _ErrorTitle="No disponible";
      _ErrorDescription=_ErrorString_NotFound;
    }
    setState(() {
      DialogDismiss=true;
      loaded=true;
    });
  }

  String _ErrorString_NetworkError="Revisa tu conecction resumen no hemos podido contactar al servidor. Intente mas tarde.";
  String _ErrorString_NotFound="El contenido buscado no esta disponible por el momento, se ha eliminado o esta en revisión. Intente mas tarde.";
  String _ErrorString_ServerError="Ha sucedido un error del lado del servidor, dispense las molestias. Intente mas tarde.";
  Future<void> ServerCall() async {

    try {
      //Base URL format: https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=CATEGORY&per_page=5&page=Pagina

      Future.delayed(Duration(milliseconds: 15000),()async{
        print("TimeOut for Connection");
        print("Dismiss Dialog: "+DialogDismiss.toString());
        if(DialogDismiss==false){SetErrorDialog(1);}
       });

      final response = await http.get(serverSettings.getFilterToSearchArticleByID(articleID.toString()),

        headers:{
          'Authorization':'Bearer '+serverSettings.getApiKey(),
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },


      ).timeout(Duration(seconds: 15), onTimeout: (){
        SetErrorDialog(1);
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
            SetErrorDialog(2);
          }
          if(response.statusCode==401){
            SetErrorDialog(3);
          }
          if(response.statusCode==404){
            SetErrorDialog(3);
          }
          throw Exception("Error");
        }
      });





    } on Exception catch(e) {
      /*if (e.toString().contains('SocketException')) {
        SetErrorDialog(1);
      }*/
      SetErrorDialog(1);
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
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _errorType==0 ?
    Scaffold(body: loaded==true ? CustomWebview(LoadingFromHTMLString: true, HTMLString:content , title: title, Mode: 2,) : LoadingWidget())
    : Scaffold(body: BasicMSGDialog(Title: _ErrorTitle,Description: _ErrorDescription, ButtonAction: (){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      Inicio_view), (Route<dynamic> route) => false);
    },ButtonColor: _ButtonColor, ButtonText: "Regresar", MessegeType: _errorType, ButtonTextColor: Colors.white,));
    //return loaded ? ArticleViewer(ArticleContent: content, title: title,) :Center(child: CircularProgressIndicator(),);
  }
}


