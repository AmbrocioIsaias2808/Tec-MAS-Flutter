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
import 'package:curved_navigation_bar/curved_navigation_bar.dart';



import 'Secciones/Calendario/Widget_Calendario.dart';

import 'Secciones/SharedClasses/Articles/Widget_Articles.dart';
import 'Secciones/Transporte/Widget_Transporte.dart';


final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final NotificationSystem notification = new NotificationSystem();
GlobalKey<ScaffoldState> ParentScaffoldkey = new GlobalKey<ScaffoldState>();
final NavigateTo = PreloadPageController(initialPage: 0);

ServerSettings serverSettings = new ServerSettings();

Widget Inicio_view=Widget_Articles(SeccionTitle: "Inicio", Category: 5,);
Widget Becas_view=Widget_Articles(SeccionTitle:"Becas", Category: 3,);
Widget Emergencias_view=Widget_Articles(SeccionTitle:"Emergencias", Category: 4,);
Widget Calendario_view=Widget_Calendario(url: "http://www.itmatamoros.edu.mx/wp-content/themes/tecnologico/pdf/Calendario_agosto_diciembre_2019.pdf",);
Widget Transporte_view=Widget_Transporte();

/*Pagina 3:*/

void OpenParentDrawer(){
  print("Opening");
  ParentScaffoldkey.currentState.openDrawer();
}

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
  int press=0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  int _currentPage=0;
  bool showBottomNavigationBar=true;
  bool BNBIcolorselected=true; //marcador para el color del icono en la BottomNavigationBar
  int AnimationDuration=500;

  @override
  void initState() {
    // TODO: implement initState
    NavigateTo.addListener(_onScroll);
  }

  void _onScroll() {
    if (NavigateTo.page.toInt() == NavigateTo.page) {
      final CurvedNavigationBarState navBarState = _bottomNavigationKey.currentState;
      navBarState.setPage(NavigateTo.page.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BarraDeNavegacion(),
      key:ParentScaffoldkey,
      extendBody: true,
      body: PreloadPageView.builder(
        physics: isSwipeEnable ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
        preloadPagesCount: 5,
        itemCount: 7,
        itemBuilder: (BuildContext context, int position) => BodyPages(position),
        controller: NavigateTo,
        onPageChanged: (int position) {
          //print('page changed. current: $position');
          PagerMovementRestrictor(position);
        },
      ),
      bottomNavigationBar:  showBottomNavigationBar==false? null : CurvedNavigationBar(
        key: _bottomNavigationKey,
        animationCurve: Curves.fastOutSlowIn,
        backgroundColor: Colors.transparent,
        color: BaseThemeColor_DarkBlue,
        animationDuration: Duration(milliseconds: AnimationDuration),
        height: 45,
        items: BottomNavigationButons(_currentPage),
        onTap: (index) {
          //print("\n\nPressed: Bottom bar index: "+ index.toString());
            _currentPage=index;
            NavigateTo.animateToPage(_currentPage, duration: Duration(milliseconds: AnimationDuration), curve: Curves.easeOutQuad);
          //Handle button tap
        },
      ),
    );
  }

  List<Widget> BottomNavigationButons(int currentPage){
    List Buttonicons=[
      Icons.dashboard,
      Icons.account_balance,
      Icons.local_hospital,
    ];
    List<Widget> Buttons=[];
    //dynamic coloricon;
    for(int i=0; i<Buttonicons.length; i++){
      /*if(currentPage==i){
        //Si esta seleccionado
        coloricon=BaseThemeColor_DarkBlue;
      }else{
        //Si no lo esta
        coloricon=Colors.white;
      }*/
      Buttons.add(Icon(Buttonicons[i], size: 18, color:Colors.white));
    }

    return Buttons;
  }

  bool isSwipeEnable=true;
  void PagerMovementRestrictor(int Page){


        if(Page==3){
          NavigateTo.animateToPage(2, duration: Duration(milliseconds: AnimationDuration), curve: Curves.easeOutBack);
        }

        if(Page<3){
          setState(() {
            showBottomNavigationBar=true;
            isSwipeEnable=true;
          });


        }

        if(Page==4 || Page==5 || Page==6){
          //Si la pagina corresponde al calendario o al Transporte o el mapa
          setState(() {
            isSwipeEnable=false;
            showBottomNavigationBar=false;
          });
        }


   // print("SwipeState: "+isSwipeEnable.toString());
    print("\n\n");
  }


}

class BodyPages extends StatelessWidget {
  BodyPages(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    //print('Page loaded: $index}');

    switch(index){
      case 0: return Inicio_view; break;
      case 1: return Becas_view; break;
      case 2: return Emergencias_view; break;
      case 3: return Scaffold(body: Offstage(),); break;
      case 4: return Calendario_view; break;
      case 5: return Transporte_view; break;
      case 6: return Scaffold(appBar: CustomAppBar(withShape: true,title: "Mapa"), drawer: BarraDeNavegacion(), body:Center(child: Text("En Desarrollo"),)); break;
    }
  }
}

