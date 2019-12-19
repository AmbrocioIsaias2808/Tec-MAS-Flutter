import 'package:flutter/material.dart';

import '../CommonlyUsed.dart';
/* Apartado en desarrollo
class CustomWebview extends StatefulWidget {
  @override
  _CustomWebviewState createState() => _CustomWebviewState();
}

class _CustomWebviewState extends State<CustomWebview> {
  final String ArticleContent;
  final String title;
  String SiteInfo="";
  String _webUserAgent="<unknown>";

  void networkConnectionCkeck() async{
    int netState = await NetworkConnectionCkeck();
    if(netState==0){
      setState(() {
        MSG_Height=40;
      });

      Future.delayed(Duration(milliseconds: 3000),(){setState(() {MSG_Height=0;});});
    }
  }

  @override
  void initState(){
    super.initState();
    initUserAgentState();
    loadHTMLfromAssets();
    networkConnectionCkeck();
    _onchanged = controllerOfWebView.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        if(state.type== WebViewState.finishLoad){ // if the full website page loaded
          setState(() {isloading=false;});
        } else if(state.type== WebViewState.startLoad){ // if the url started loading
          setState(() {isloading=true;});
        }else if (state.type== WebViewState.abortLoad){ // if there is a problem with loading the url
          setState(() {isloading=false;});
        }
      }
    });
  }

  void loadHTMLfromAssets() async{
    SiteInfo = await rootBundle.loadString(filePath)+ArticleContent+'</div></body></html>';
    setState(() {});
  }

  _ArticlePageState({@required this.ArticleContent, @required this.title});

  final controllerOfWebView = new FlutterWebviewPlugin();



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

  void loadingAnimation(){
    if(isloading==true){
      controllerOfWebView.stopLoading();
    }else{
      controllerOfWebView.reload();
    }
    setState(() {
      isloading=!isloading;
    });
  }

  double MSG_Height=0;
  int MSG_timing=500;
  StreamSubscription<WebViewStateChanged> _onchanged;
  bool isloading=false;

  String filePath='assets/ArticleViewer/base.html';
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      initialChild: LoadingWidget(),
      url: Uri.dataFromString(SiteInfo, mimeType: 'text/html',  encoding: Encoding.getByName('utf-8')).toString(),
      withJavascript: true,
      withZoom: true,
      allowFileURLs: true,
      withOverviewMode: true,
      useWideViewPort: true,
      userAgent: _webUserAgent,
      supportMultipleWindows: true,
      bottomNavigationBar: Stack(
        children: <Widget>[
          BarraDeNavegacion(isloading: isloading, loadingAnimation: loadingAnimation, controlladorDeWebview: controllerOfWebView,),
          AnimatedContainer(
            // Use the properties stored in the State class.
            width: media.width-2,
            height:MSG_Height,
            color: BaseThemeColor_DarkLightBlue,
            // Define how long the animation should take.
            duration: Duration(milliseconds: MSG_timing),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
            child: Center(
              child: FlatButton(
                child: Text("No he podido conectarme a Internet. Es posible que algunos elementos no se visualicen correctamente.", style: BaseThemeText_whiteBold1) ,
                onPressed: (){setState(() {
                  MSG_Height=0;
                });},
              ),
            ),
          )
        ],
      ),
    );

  }


}
/*Barra de navegacion*/
/*Codigo de la barra de navegacion*/

class BarraDeNavegacion extends StatelessWidget {

  Function loadingAnimation;
  bool isloading;
  dynamic controlladorDeWebview; //Controllador del webview

  BarraDeNavegacion({@required this.loadingAnimation, @required this.isloading, @required this.controlladorDeWebview});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color:BaseThemeColor_DarkLightBlue,
      child: Material(
        borderRadius: BorderRadius.circular(50),
        type: MaterialType.transparency,
        color:Colors.transparent,
        child: Row(
          children: <Widget>[
            Expanded(child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
              splashColor: BaseThemeColor_DarkBlue,
              onPressed: (){
                print("Going back");
                controlladorDeWebview.goBack();
              },),),
            Expanded(child: Padding(padding: EdgeInsets.all(3.1),child:BotonRefresh(loading: isloading, GestorDeAnimacion: loadingAnimation),)),
            Expanded(child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
              splashColor: BaseThemeColor_DarkBlue,
              onPressed: (){
                print("Foward");

                controlladorDeWebview.goForward();
              },),)
          ],
        ),
      ),
    );
  }
}


/*Boton de refresco o refresh de la barra de navegacion*/
/*Codigo del boton Refresh de la barra de navegacion*/

class BotonRefresh extends StatelessWidget {

  bool loading;
  Function GestorDeAnimacion;

  BotonRefresh({@required this.loading, @required this.GestorDeAnimacion});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                child: loading ? CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)):null,
              ),
            ),
            Center(child:
            Icon(loading ? Icons.clear : Icons.refresh)
            )
          ],
        ),
      ),
      //child:
      backgroundColor: Colors.blueAccent,
      splashColor: BaseThemeColor_DarkBlue,
      onPressed: GestorDeAnimacion,
    );
  }
}


*/