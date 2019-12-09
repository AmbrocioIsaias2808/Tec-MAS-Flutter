import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';


class ArticleViewer extends StatefulWidget {

  final String ArticleContent;
  final String title;

  ArticleViewer({@required this.ArticleContent, @required this.title});

  @override
  _ArticleViewerState createState() => _ArticleViewerState(ArticleContent:this.ArticleContent, title:this.title);
}

class _ArticleViewerState extends State<ArticleViewer> {
  final String ArticleContent;
  final String title;


  _ArticleViewerState({@required this.ArticleContent, @required this.title});
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
