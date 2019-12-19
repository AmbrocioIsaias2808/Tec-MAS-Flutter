import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'dart:convert';
import 'package:flutter_user_agent/flutter_user_agent.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import '../CommonlyUsed.dart';



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
  String SiteInfo="";
  String _webUserAgent="<unknown>";

  void networkConnectionCkeck() async{
    int netState = await NetworkConnectionCkeck();
    if(netState==0){
      setState(() {

        ShowSnackWithDelay(context, 1200, BasicSnack("Lo siento, no he podido conectarme a Internet. Es posible que algunos elementos no se visualicen correctamente."));
      });
    }
  }

  @override
  void initState(){
    super.initState();
    initUserAgentState();
    loadHTMLfromAssets();
    networkConnectionCkeck();
  }

  void loadHTMLfromAssets() async{
    SiteInfo = await rootBundle.loadString(filePath)+ArticleContent+'</div></body></html>';
    setState(() {});
  }

  _ArticlePageState({@required this.ArticleContent, @required this.title});



  Future<void> initUserAgentState() async {
    String webViewUserAgent;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await FlutterUserAgent.init();
      webViewUserAgent = FlutterUserAgent.webViewUserAgent;
      print("\n\n\nUserAgent: "+webViewUserAgent);
    } on PlatformException {
      webViewUserAgent = '<error>';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _webUserAgent = webViewUserAgent;
    });
  }

  String filePath='assets/ArticleViewer/base.html';
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      allowFileURLs: true,
      withOverviewMode: true,
      useWideViewPort: true,
      userAgent: _webUserAgent,
      supportMultipleWindows: true,
        persistentFooterButtons: <Widget>[
          Container(child: Text("Hola mundo"),),
        ],
        appBar: AppBar(title: Text(title),
        backgroundColor: BaseThemeAppBarColor),
        url: Uri.dataFromString(SiteInfo, mimeType: 'text/html',  encoding: Encoding.getByName('utf-8')).toString(),
        withJavascript: true,
        withZoom: true,
    );

  }


}
