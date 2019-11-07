import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Secciones/SII/Widget_SII.dart';
import 'package:tecmas/Secciones/SharedClasses/Articles/Articles.dart';
import 'package:tecmas/Temas/BaseTheme.dart';

import 'Secciones/Calendario/Widget_Calendario.dart';


void main(){
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return AppState();
  }
}

class AppState extends State<App> {

  double SeccionActual;
  String text="Inicio";
  dynamic Seccion=Text("Inicio");

  void funcSeccionActual(double NumSeccion, var contexto){
    setState(() {
      if(NumSeccion==1.0){Seccion=Widget_Articles();}
      if(NumSeccion==2.0){Seccion=Text("Becas");}
      if(NumSeccion==3.0){Seccion=Widget_Calendario();}
      if(NumSeccion==4.0){Seccion=Text("Transporte");}
      if(NumSeccion==5.0){Seccion=Text("Emergencias");}
      if(NumSeccion==6.0){Seccion=Text("Mapa Interactivo");}
      //if(NumSeccion==7.0){Seccion=Widget_SII();}

      Navigator.pop(contexto);
    }
    );
  }

  var isDrawerOpen=false;


  void _handleDrawer(){


    setState(() {
      _key.currentState.openDrawer();

      isDrawerOpen=!isDrawerOpen;
      print("\n\n\n\n\n\nDrawer: "+isDrawerOpen.toString());
      box=_key.currentContext?.findRenderObject();
      if(box!=null){
        print("\n\n\n\n\n\nABIERTO");
      }else{print("\n\n\n\n\nCERRADO");}
    });

  }

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  RenderBox box;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Tec-MAS Develop",
      home:Scaffold(
          key: _key,
        appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.menu),
              onPressed:_handleDrawer,
            ),
          title:   Text("Tec-Mas"),
          backgroundColor:BaseThemeColor_DarkLightBlue,

        ),
        drawer: BarraDeNavegacion(funcSeccionActual: funcSeccionActual),
        body: Container(
          child: Center(
            child: Seccion,
          ),
        ),
      )
    );

  }
}





