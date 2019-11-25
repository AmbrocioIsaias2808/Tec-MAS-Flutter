import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tecmas/Notifications/OneSignal/OneSignal.dart';
//import 'package:tecmas/Notifications/OneSignal/OneSignal.dart';
import 'package:tecmas/Secciones/SharedClasses/RestartApp.dart';

import 'Secciones/Calendario/Widget_Calendario.dart';

import 'Secciones/SharedClasses/Articles/Widget_Articles.dart';
import 'Secciones/Transporte/Widget_Transporte.dart';


final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final NotificationSystem notification = new NotificationSystem();



void main(){
  runApp(App());
}


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  

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


      initialRoute: '/',
      routes: {
        '/':(context)=>Widget_Articles(SeccionTitle: "Inicio",URL:'https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=2'),
        '/Becas':(context)=>Widget_Articles(SeccionTitle:"Becas",URL:'https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=3'),
        '/Calendario':(context)=>Widget_Calendario(URL: "http://www.itmatamoros.edu.mx/wp-content/themes/tecnologico/pdf/Calendario_agosto_diciembre_2019",),
        '/Transporte': (context)=>Widget_Transporte(),
        '/Emergencias':(context)=>Widget_Articles(SeccionTitle:"Emergencias", URL:'https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=4'),
        '/Mapa':(context)=>Scaffold(appBar: AppBar(title: Text('Mapa'),),drawer: BarraDeNavegacion(),body:Center(child: Text("Mapa Interactivo", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),),
      },

    );
  }
}
