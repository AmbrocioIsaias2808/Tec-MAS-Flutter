import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tecmas/Notifications/OneSignal/OneSignal.dart';
import 'package:tecmas/Secciones/SII/Widget_SII.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/NotificationArticleViewer.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/SavedArticles.dart';
import 'package:tecmas/Secciones/SharedClasses/CustomAppBar.dart';
import 'package:tecmas/Secciones/SharedClasses/ServerSettings.dart';
import 'package:tecmas/Secciones/pol.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'package:preload_page_view/preload_page_view.dart';
//import 'package:tecmas/Notifications/OneSignal/OneSignal.dart';


import 'Secciones/Calendario/Widget_Calendario.dart';

import 'Secciones/SharedClasses/Articles/Widget_Articles.dart';
import 'Secciones/Transporte/Widget_Transporte.dart';


final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final NotificationSystem notification = new NotificationSystem();

final NavigateTo = PreloadPageController(initialPage: 0);

ServerSettings serverSettings = new ServerSettings();

Widget Inicio_view=Widget_Articles(SeccionTitle: "Inicio", Category: 2,);
Widget Becas_view=Widget_Articles(SeccionTitle:"Becas", Category: 3,);
Widget Emergencias_view=Widget_Articles(SeccionTitle:"Emergencias", Category: 4,);
Widget Calendario_view=Widget_Calendario(url: "http://www.itmatamoros.edu.mx/wp-content/themes/tecnologico/pdf/Calendario_agosto_diciembre_2019.pdf",);
Widget Transporte_view=Widget_Transporte();

/*Pagina 3:*/


void main(){
  runApp(App());
}


dynamic Appcontext;
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
      theme: BaseTheme(),
      navigatorKey: navigatorKey,
      title:"Tec-MAS Develop",
        routes: {
          '/Favoritos':(context)=>SavedArticles(),
          '/SII':(context)=>Widget_SII(),
          '/pol':(context)=>pol(),
          "/":(context)=>AppBody(),
        },
      initialRoute: "/",

    );
  }
}


class AppBody extends StatefulWidget {
  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PreloadPageView.builder(
        preloadPagesCount: 5,
        itemCount: 6,
        itemBuilder: (BuildContext context, int position) => DemoPage(position),
        controller: NavigateTo,
        onPageChanged: (int position) {
          print('page changed. current: $position');
        },
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  DemoPage(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    print('Page loaded: $index}');

    switch(index){
      case 0: return Inicio_view; break;
      case 1: return Becas_view; break;
      case 2: return Calendario_view; break;
      case 3: return Transporte_view; break;
      case 4: return Emergencias_view; break;
      case 5: return Transporte_view; break;
    }
  }
}
