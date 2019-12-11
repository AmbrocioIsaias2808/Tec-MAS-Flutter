import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

import '../CommonlyUsedFunctions.dart';

class ArticleViewer extends StatelessWidget {

  final String ArticleContent;
  final String title;

  ArticleViewer({@required this.ArticleContent, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArticlePage(ArticleContent: ArticleContent, title: title),
    );
  }
}


class ArticlePage extends StatefulWidget {

  final String ArticleContent;
  final String title;

  ArticlePage({@required this.ArticleContent, @required this.title});

  @override
  _ArticlePageState createState() => _ArticlePageState(ArticleContent:this.ArticleContent, title:this.title);
}

class _ArticlePageState extends State<ArticlePage> {
  final String ArticleContent;
  final String title;

  void networkConnectionCkeck() async{
    int netState = await NetworkConnectionCkeck();
    if(netState==0){
      setState(() {

        Future.delayed(Duration(milliseconds: 1200),(){
          final MSG = SnackBar(backgroundColor: BaseThemeColor_DarkBlue,
            content: Text("Lo siento, no he podido conectarme a Internet. Es posible que algunos elementos no se visualicen correctamente.",
            style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.justify,));
          Scaffold.of(context).showSnackBar(MSG);

        });

      });
    }
  }

  @override
  void initState(){
    networkConnectionCkeck();
  }


  _ArticlePageState({@required this.ArticleContent, @required this.title});
  WebViewController webController;

  String filePath='assets/ArticleViewer/base.html';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: BarraDeNavegacion(),
      appBar: AppBar(title: Text(title),
      backgroundColor: BaseThemeAppBarColor,
      actions: <Widget>[
        Padding(
          child: InkWell(child: (Icon(Icons.arrow_back_ios)),onTap: ()async{
            if (await webController.canGoBack()) {
            print("onwill goback");
            webController.goBack();
            }


          },),
          padding: EdgeInsets.fromLTRB(0,10,10,10),),
        SizedBox(width: 10,),
        Padding(
          child: InkWell(child: (Icon(Icons.arrow_forward_ios)),onTap: ()async{
            if (await webController.canGoForward()) {
            print("onwill goback");
            webController.goForward();
            }
          },),
          padding: EdgeInsets.fromLTRB(0,10,10,10),),
      ],),
      body:Container(
          decoration: BoxDecoration(
            borderRadius:BorderRadius.only(topLeft: Radius.circular(75.0)),
          ),
        child:

              WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller){
                  webController=controller;
                  _loadHTMLfromAssets();
                },
              ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: BaseThemeColor_DarkBlue,
        mini: true,
        child: Icon(Icons.refresh),
        onPressed: (){

          setState(() {
            webController.reload();
          });


        },
      ),
    );
  }

  _loadHTMLfromAssets() async{
    String fileHTMLContents = await rootBundle.loadString(filePath)+ArticleContent+'</div></body></html>';
    webController.loadUrl(
        Uri.dataFromString(fileHTMLContents,mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString()
    );

  }
}
