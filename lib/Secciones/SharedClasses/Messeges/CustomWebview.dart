import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';

import '../CommonlyUsed.dart';
import '../LoadingWidget.dart';

class CustomWebview extends StatefulWidget {

  String SITE;
  final String PATH_FROMLOCALFILE;
  final String HTMLString;
  final String title;
  bool LoadingFromAssets;
  bool LoadingFromHTMLString;
  bool CombineFileAndHTMLBODY;
  bool clearCache;
  bool clearCookies;
  bool AlertMessege;

  CustomWebview({this.SITE="",this.PATH_FROMLOCALFILE="", this.title="", this.LoadingFromAssets=false, this.HTMLString="", this.LoadingFromHTMLString=false, this.CombineFileAndHTMLBODY=false, this.clearCache=false, this.clearCookies=false, this.AlertMessege=false});

  @override
  _CustomWebviewState createState() => _CustomWebviewState(SITE: SITE, PATH_FROMLOCALFILE: PATH_FROMLOCALFILE, title: title, LoadingFromAssets: LoadingFromAssets, HTMLString: HTMLString, LoadingFromHTMLString: LoadingFromHTMLString, CombineFileAndHTMLBODY: CombineFileAndHTMLBODY, clearCache: clearCache, clearCookies: clearCookies, AlertMessege: AlertMessege);
}

class _CustomWebviewState extends State<CustomWebview> {

  String SITE;
  final String PATH_FROMLOCALFILE;
  final String HTMLString;
  final String title;
  String _webUserAgent="<unknown>";
  bool LoadingFromAssets;
  bool LoadingFromHTMLString;
  bool CombineFileAndHTMLBODY;
  bool clearCache;
  bool clearCookies;
  static const String error='<!DOCTYPE><html><head><style>p{font-size:30px}</style></head><body><p>Estas haciendo algo mal, checa los parametros y los valores</p><p>You Are Doing Something Wrong, Check the parameters and Values</p></body></html>';
  bool AlertMessege;
  _CustomWebviewState({this.SITE="",this.PATH_FROMLOCALFILE="", this.title="", this.LoadingFromAssets=false, this.HTMLString="", this.LoadingFromHTMLString=false, this.CombineFileAndHTMLBODY=false, this.clearCache=false, this.clearCookies=false, this.AlertMessege=false});


  int netState;
  void networkConnectionCkeck() async{
    int netState = await NetworkConnectionCkeck();
    if(netState==0 && AlertMessege==false){
      Messege("No he podido conectarme a Internet. Es posible que algunos elementos no se visualicen correctamente.");
    }else if(netState==1 && AlertMessege==true){
      Messege("Como medida de seguridad te recomendamos cerrar sesión cuando termines tu cosulta");
    }else if(netState==0 && AlertMessege==true){
      Messege("No he podido conectarme a Internet");
    }
  }

  String AlertMessegeString="";
  void Messege(String MSG){
    setState(() {
      AlertMessegeString=MSG;
      MSG_Height=40;
    });

    Future.delayed(Duration(milliseconds: 3000),(){setState(() {MSG_Height=0;});});
  }

  void loadFrom() async{
    String from='';
    print("FromASSETS: "+LoadingFromAssets.toString()+" fromString: "+LoadingFromHTMLString.toString()+" Combinado: "+CombineFileAndHTMLBODY.toString());
    if(LoadingFromAssets==true && LoadingFromHTMLString==false && CombineFileAndHTMLBODY==false){
      //Entonces se cargara desde un archivo
      print("Loading From A FILE");
      from = await rootBundle.loadString(PATH_FROMLOCALFILE);
    }else if(LoadingFromAssets==false && LoadingFromHTMLString==true && CombineFileAndHTMLBODY==false){
      //Se renderizara una cadena con texto en codigo HTML
      from = HTMLString;
      print("Loading From HTML");
    }else if(LoadingFromAssets==false && LoadingFromHTMLString==false && CombineFileAndHTMLBODY==true){
      //Cargaremos contenido desde un archivo pero el body del mismo sera cargado desde una cadena html
      from = await rootBundle.loadString(PATH_FROMLOCALFILE)+HTMLString+'</div></body></html>';
      print("Loading From A FILE AND HTML");
    }else{

      if(SITE.length!=0){
        from=SITE;
        print("Loading INTERNET:"+from);
      }
      else{
        print("Loading INTERNET:"+from);
        LoadingFromHTMLString=true;
        from=error;
      }
    }
      //Si todo lo anterior falla significa que estaremos cargado una pagina web normal y corriente desde internet, por lo tanto SITE debe contener una URL

    setState(() {
      SITE=from;
    });
  }

  @override
  void initState(){
    super.initState();
    loadFrom();
    initUserAgentState();
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


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      initialChild: LoadingWidget(),
      url: (LoadingFromAssets==true || LoadingFromHTMLString==true || CombineFileAndHTMLBODY==true)? Uri.dataFromString(SITE, mimeType: 'text/html',  encoding: Encoding.getByName('utf-8')).toString():SITE,
      withJavascript: true,
      withZoom: true,
      clearCache: clearCache,
      clearCookies: clearCookies,
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
                child: Text(AlertMessegeString, style: BaseThemeText_whiteBold1) ,
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


