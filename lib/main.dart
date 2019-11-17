import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tecmas/BarraDeNavegacion/Drawer.dart';
import 'package:tecmas/Secciones/SII/Widget_SII.dart';

import 'package:tecmas/Temas/BaseTheme.dart';

import 'Secciones/Calendario/Widget_Calendario.dart';
import 'Secciones/Estructures/Articles.dart';

import 'Secciones/SharedClasses/Articles/Widget_Articles.dart';
import 'Secciones/Transporte/Widget_Transporte.dart';
import 'Secciones/pol.dart';


void main(){
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:"Tec-MAS Develop",
        initialRoute: '/',
      routes: {
          '/':(context)=>Widget_Articles(SeccionTitle: "Inicio",URL:'https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=2&per_page=5&page='),
          '/Becas':(context)=>Widget_Articles(SeccionTitle:"Becas",URL:'https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=3&per_page=5&page='),
          '/Calendario':(context)=>Widget_Calendario(),
          '/Transporte': (context)=>Widget_Transporte(),
          '/Emergencias':(context)=>Widget_Articles(SeccionTitle:"Emergencias", URL:'https://wordpresspruebas210919.000webhostapp.com/wp-json/wp/v2/posts?categories=4&per_page=5&page='),
          '/Mapa':(context)=>Scaffold(appBar: AppBar(title: Text('Mapa'),),drawer: BarraDeNavegacion(),body:Center(child: Text("Mapa Interactivo", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),),
      },

    );
  }
}
