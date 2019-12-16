import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tecmas/Notifications/OneSignal/OneSignal.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/SavedArticles.dart';
//import 'package:tecmas/Notifications/OneSignal/OneSignal.dart';


import 'Secciones/Calendario/Widget_Calendario.dart';

import 'Secciones/SharedClasses/Articles/Widget_Articles.dart';
import 'Secciones/Transporte/Widget_Transporte.dart';


final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final NotificationSystem notification = new NotificationSystem();

final NavigateTo = PageController();

void main(){
  runApp(App());
}


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  static String Pagina_URL="https://wordpresspruebas210919.000webhostapp.com";
  //static String Pagina_URL="http://192.168.1.106:80/wordpress";
  static String Api_Filter="/wp-json/wp/v2/posts?categories=";

  final String Api_Request_URL=Pagina_URL+Api_Filter;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notification.setNavigator(navigatorKey);
    notification.init();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title:"Tec-MAS Develop",
        routes: {
          '/Favoritos':(context)=>SavedArticles(),
        },
      home:PageView(
        controller: NavigateTo,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          /*Pagina 0:*/ Widget_Articles(SeccionTitle: "Inicio",URL:Api_Request_URL, Category: 2,),
          /*Pagina 1:*/ Widget_Articles(SeccionTitle:"Becas",URL:Api_Request_URL, Category: 3,),
          /*Pagina 2:*/ Widget_Calendario(URL: "http://www.itmatamoros.edu.mx/wp-content/themes/tecnologico/pdf/Calendario_agosto_diciembre_2019",),
          /*Pagina 3:*/ Widget_Transporte(),
          /*Pagina 4:*/ Widget_Articles(SeccionTitle:"Emergencias", URL:Api_Request_URL, Category: 4,),
          /*Pagina 5:*/ Scaffold(appBar: AppBar(title: Text('Mapa'),),drawer: BarraDeNavegacion(),body:Center(child: Text("Mapa Interactivo", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),),
        ],
      )

    );
  }
}
